------------------------------------------------------------------------------
-- Json Decode
-- https://github.com/rxi/json.lua
-------------------------------------------------------------------------------

local parse

local function create_set(...)
  local res = {}
  for i = 1, select("#", ...) do
    res[ select(i, ...) ] = true
  end
  return res
end

local space_chars   = create_set(" ", "\t", "\r", "\n")
local delim_chars   = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
local escape_chars  = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
local literals      = create_set("true", "false", "null")

local literal_map = {
  [ "true"  ] = true,
  [ "false" ] = false,
  [ "null"  ] = nil,
}

local function next_char(str, idx, set, negate)
  for i = idx, #str do
    if set[str:sub(i, i)] ~= negate then
      return i
    end
  end
  return #str + 1
end

local function decode_error(str, idx, msg)
  local line_count = 1
  local col_count = 1
  for i = 1, idx - 1 do
    col_count = col_count + 1
    if str:sub(i, i) == "\n" then
      line_count = line_count + 1
      col_count = 1
    end
  end
  error( string.format("%s at line %d col %d", msg, line_count, col_count) )
end

local function codepoint_to_utf8(n)
  -- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
  local f = math.floor
  if n <= 0x7f then
    return string.char(n)
  elseif n <= 0x7ff then
    return string.char(f(n / 64) + 192, n % 64 + 128)
  elseif n <= 0xffff then
    return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
  elseif n <= 0x10ffff then
    return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128,
                       f(n % 4096 / 64) + 128, n % 64 + 128)
  end
  error( string.format("invalid unicode codepoint '%x'", n) )
end

local function parse_unicode_escape(s)
  local n1 = tonumber( s:sub(1, 4),  16 )
  local n2 = tonumber( s:sub(7, 10), 16 )
   -- Surrogate pair?
  if n2 then
    return codepoint_to_utf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
  else
    return codepoint_to_utf8(n1)
  end
end

local function parse_string(str, i)
  local res = ""
  local j = i + 1
  local k = j

  while j <= #str do
    local x = str:byte(j)

    if x < 32 then
      decode_error(str, j, "control character in string")

    elseif x == 92 then -- `\`: Escape
      res = res .. str:sub(k, j - 1)
      j = j + 1
      local c = str:sub(j, j)
      if c == "u" then
        local hex = str:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", j + 1)
                 or str:match("^%x%x%x%x", j + 1)
                 or decode_error(str, j - 1, "invalid unicode escape in string")
        res = res .. parse_unicode_escape(hex)
        j = j + #hex
      else
        if not escape_chars[c] then
          decode_error(str, j - 1, "invalid escape char '" .. c .. "' in string")
        end
        res = res .. escape_char_map_inv[c]
      end
      k = j + 1

    elseif x == 34 then -- `"`: End of string
      res = res .. str:sub(k, j - 1)
      return res, j + 1
    end

    j = j + 1
  end

  decode_error(str, i, "expected closing quote for string")
end

local function parse_number(str, i)
  local x = next_char(str, i, delim_chars)
  local s = str:sub(i, x - 1)
  local n = tonumber(s)
  if not n then
    decode_error(str, i, "invalid number '" .. s .. "'")
  end
  return n, x
end

local function parse_literal(str, i)
  local x = next_char(str, i, delim_chars)
  local word = str:sub(i, x - 1)
  if not literals[word] then
    decode_error(str, i, "invalid literal '" .. word .. "'")
  end
  return literal_map[word], x
end

local function parse_array(str, i)
  local res = {}
  local n = 1
  i = i + 1
  while 1 do
    local x
    i = next_char(str, i, space_chars, true)
    -- Empty / end of array?
    if str:sub(i, i) == "]" then
      i = i + 1
      break
    end
    -- Read token
    x, i = parse(str, i)
    res[n] = x
    n = n + 1
    -- Next token
    i = next_char(str, i, space_chars, true)
    local chr = str:sub(i, i)
    i = i + 1
    if chr == "]" then break end
    if chr ~= "," then decode_error(str, i, "expected ']' or ','") end
  end
  return res, i
end

local function parse_object(str, i)
  local res = {}
  i = i + 1
  while 1 do
    local key, val
    i = next_char(str, i, space_chars, true)
    -- Empty / end of object?
    if str:sub(i, i) == "}" then
      i = i + 1
      break
    end
    -- Read key
    if str:sub(i, i) ~= '"' then
      decode_error(str, i, "expected string for key")
    end
    key, i = parse(str, i)
    -- Read ':' delimiter
    i = next_char(str, i, space_chars, true)
    if str:sub(i, i) ~= ":" then
      decode_error(str, i, "expected ':' after key")
    end
    i = next_char(str, i + 1, space_chars, true)
    -- Read value
    val, i = parse(str, i)
    -- Set
    res[key] = val
    -- Next token
    i = next_char(str, i, space_chars, true)
    local chr = str:sub(i, i)
    i = i + 1
    if chr == "}" then break end
    if chr ~= "," then decode_error(str, i, "expected '}' or ','") end
  end
  return res, i
end

local char_func_map = {
  [ '"' ] = parse_string,
  [ "0" ] = parse_number,
  [ "1" ] = parse_number,
  [ "2" ] = parse_number,
  [ "3" ] = parse_number,
  [ "4" ] = parse_number,
  [ "5" ] = parse_number,
  [ "6" ] = parse_number,
  [ "7" ] = parse_number,
  [ "8" ] = parse_number,
  [ "9" ] = parse_number,
  [ "-" ] = parse_number,
  [ "t" ] = parse_literal,
  [ "f" ] = parse_literal,
  [ "n" ] = parse_literal,
  [ "[" ] = parse_array,
  [ "{" ] = parse_object,
}

parse = function(str, idx)
  local chr = str:sub(idx, idx)
  local f = char_func_map[chr]
  if f then
    return f(str, idx)
  end
  decode_error(str, idx, "unexpected character '" .. chr .. "'")
end

function json_decode(str)
  if type(str) ~= "string" then
    error("expected argument of type string, got " .. type(str))
  end
  local res, idx = parse(str, next_char(str, 1, space_chars, true))
  idx = next_char(str, idx, space_chars, true)
  if idx <= #str then
    decode_error(str, idx, "trailing garbage")
  end
  return res
end

-- Read pywal json colors
local open = io.open
local file = open(os.getenv("HOME").."/.cache/wal/colors.json", "rb")
if not file then return nil end
local jsonString = file:read "*a"
file:close()
local colors = json_decode(jsonString)["colors"]

-- Start theme
if not gr.select_engine("de") then
    return
end

de.reset()

de.defstyle("*", {
    highlight_colour = colors["color2"],
    shadow_colour = colors["color2"],
    background_colour = colors["color2"],
    foreground_colour = colors["color0"],

    border_style = "elevated",
    padding_pixels = 0,
    highlight_pixels = 3,
    shadow_pixels = 3,
    spacing = 0,

    font = "xft:Monospace:size=11:antialias=True",
    text_align = "center",
})

de.defstyle("frame", {
    background_colour = "#000000",
    foreground_colour = "#ffffff",
    transparent_background = true,

    de.substyle("active", {
      highlight_colour = colors["color1"],
      shadow_colour = colors["color1"],
      foreground_colour = colors["color0"],
    }),

    de.substyle("inactive", {
      shadow_colour = colors["color3"],
      highlight_colour = colors["color3"],
      foreground_colour = colors["color7"],
    }),
})

de.defstyle("frame-ionframe", {
    based_on = "frame",
    border_style = "inlaid",
    spacing = 1,
})

de.defstyle("frame-floatframe", {
    based_on = "frame",
    border_style = "ridge",
})

de.defstyle("tab", {
    font = "xft:Monospace:Bold:size=9:antialias=True",
    text_align = "center",

    de.substyle("active-selected", {
        highlight_colour = colors["color0"],
        shadow_colour = colors["color0"],
        background_colour = colors["color1"],
        foreground_colour = colors["color7"],
    }),

    de.substyle("inactive-selected", {
        highlight_colour = colors["color3"],
        shadow_colour = colors["color3"],
        background_colour = colors["color3"],
        foreground_colour = colors["color7"],
    }),

    de.substyle("active-unselected", {
        shadow_colour = colors["color2"],
        highlight_colour = colors["color2"],
        background_colour = colors["color2"],
        foreground_colour = colors["color7"],
    }),

    de.substyle("inactive-unselected", {
        highlight_colour = colors["color3"],
        shadow_colour = colors["color3"],
        background_colour = colors["color3"],
        foreground_colour = colors["color7"],
    }),
})

de.defstyle("tab-frame", {
    de.substyle("inactive-*-*-*-activity", {
        highlight_colour = colors["color3"],
        shadow_colour = colors["color3"],
        background_colour = colors["color3"],
        foreground_colour = colors["color7"],
    }),

    de.substyle("active-*-*-*-activity", {
        highlight_colour = colors["color1"],
        shadow_colour = colors["color1"],
        background_colour = colors["color1"],
        foreground_colour = colors["color7"],
    }),
})

de.defstyle("tab-menuentry", {
    text_align = "left",
    border_sides = "tb",
    padding_pixels = 0,
    spacing = 0,

   de.substyle("inactive-selected", {
          highlight_colour = colors["color1"],
          shadow_colour = colors["color1"],
          background_colour = colors["color1"],
          foreground_colour = colors["color7"],
      }),

      de.substyle("inactive-unselected", {
          highlight_colour = colors["color3"],
          shadow_colour = colors["color3"],
          background_colour = colors["color3"],
          foreground_colour = colors["color7"],
      }),

})

de.defstyle("tab-menuentry-big", {
    padding_pixels = 4,
})

de.defstyle("input", {
    text_align = "left",
    spacing = 1,
    highlight_colour = colors["color1"],
    shadow_colour = colors["color1"],
    background_colour = colors["color1"],
    foreground_colour = colors["color7"],

    de.substyle("*-selection", {
        background_colour = colors["color3"],
        foreground_colour = colors["color7"],
    }),

    de.substyle("*-cursor", {
        background_colour = colors["color1"],
        foreground_colour = colors["color0"],
    }),
})

de.defstyle("stdisp", {
    shadow_pixels = 0,
    highlight_pixels = 0,
    padding_pixels = 0,
    spacing = 0,
    text_align = "center",
    background_colour = colors["color1"],
    foreground_colour = colors["color7"],

    de.substyle("important", {
        foreground_colour = colors["color7"],
    }),

    de.substyle("critical", {
        foreground_colour = colors["color7"],
    }),
})

gr.refresh()
