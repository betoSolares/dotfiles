local gears = require("gears")
local awful = require("awful")

local _M = {}

function _M.get(screen)
  local layoutbox = awful.widget.layoutbox(screen)

  layoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))

  return layoutbox
end

return setmetatable({}, {
  __call = function(_, ...)
    return _M.get(...)
  end,
})
