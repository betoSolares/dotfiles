local wibox = require("wibox")
local awful = require("awful")
local color = require("topbar.colors")

local _M = {}

function _M.get()
  local power = wibox.widget({
    markup = '<span color="' .. color.fg_focus .. '" font="GoMono Nerd Font 12"> </span>',
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  })

  power:buttons(awful.util.table.join(awful.button({}, 1, function()
    awful.spawn("powermenu")
  end)))

  return power
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
