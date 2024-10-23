local awful = require("awful")

awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
}

local _M = {}

function _M.get()
  local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
  }

  return layouts
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
