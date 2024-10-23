local wibox = require("wibox")

local _M = {}

function _M.get()
  local separator = wibox.widget.textbox(" ")
  return separator
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
