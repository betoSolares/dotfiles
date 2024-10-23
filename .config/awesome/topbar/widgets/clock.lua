local wibox = require("wibox")
local color = require("topbar.colors")

local _M = {}

function _M.get()
  local icon = '<span color="' .. color.fg_focus .. '" font="GoMono Nerd Font 12"> </span>'
  local text = '<span color="' .. color.fg_normal .. '" font="GoMono Nerd Font 12">%H:%M</span>'

  local mytextclock = wibox.widget.textclock(icon .. text)

  return mytextclock
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
