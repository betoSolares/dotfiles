local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local color = require("topbar.colors")

local _M = {}

function _M.get()
  local volume = wibox.widget({
    markup = "",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  })

  local function get_mute()
    local handle = io.popen("LC_ALL=C pactl get-sink-mute @DEFAULT_SINK@")
    if not handle then
      return nil
    end

    local stdout = handle:read("*a")
    handle:close()

    if string.find(stdout, "yes") then
      return true
    else
      return false
    end
  end

  local function get_volume()
    local handle = io.popen("pactl get-sink-volume @DEFAULT_SINK@")
    if not handle then
      return nil
    end

    local stdout = handle:read("*a")
    handle:close()

    local volsum, volcnt = 0, 0
    for vol in string.gmatch(stdout, "(%d?%d?%d)%%") do
      local percent = tonumber(vol)

      if vol ~= nil then
        volsum = volsum + percent
        volcnt = volcnt + 1
      end
    end

    if volcnt == 0 then
      return nil
    end

    return volsum / volcnt
  end

  local function update_widget()
    local vol_icon, vol_level

    if get_mute() then
      vol_icon = "󰝟 "
      vol_level = ""
    else
      local vol = get_volume()

      if vol ~= nil then
        if vol >= 0 and vol < 33 then
          vol_icon = "󰕿 "
        elseif vol < 66 then
          vol_icon = "󰖀 "
        else
          vol_icon = "󰕾 "
        end

        vol_level = string.format("%d%%", vol)
      else
        vol_icon = "󰖁 "
        vol_level = ""
      end
    end

    local icon = '<span color="' .. color.fg_focus .. '" font="GoMono Nerd Font 12">' .. vol_icon .. "</span>"
    local text = '<span color="' .. color.fg_normal .. '" font="GoMono Nerd Font 12">' .. vol_level .. "</span>"

    volume.markup = icon .. text
  end

  volume:buttons(awful.util.table.join(awful.button({}, 1, function()
    awful.spawn("pavucontrol")
  end)))

  gears.timer({
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function()
      update_widget()
    end,
  })

  return volume
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
