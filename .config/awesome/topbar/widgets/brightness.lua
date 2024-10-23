local wibox = require("wibox")
local watch = require("awful.widget.watch")
local color = require("topbar.colors")

local _M = {}

function _M.get()
  local brightness = wibox.widget({
    markup = "",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  })

  local timeout = 5

  watch("sh -c 'brightnessctl -m | cut -d, -f4 | tr -d %'", timeout, function(widget, stdout)
    local level = tonumber(string.format("%.0f", stdout))

    local icon = '<span color="' .. color.fg_focus .. '" font="GoMono Nerd Font 12">󰃠 </span>'
    local text = '<span color="'
      .. color.fg_normal
      .. '" font="GoMono Nerd Font 12">'
      .. string.format("%d%%", level)
      .. " </span>"

    widget.markup = icon .. text
  end, brightness)

  return brightness
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
