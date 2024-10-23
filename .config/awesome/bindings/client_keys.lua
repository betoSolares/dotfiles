local gears = require("gears")
local awful = require("awful")

local _M = {}

local modkey = RC.vars.modkey

function _M.get()
  local clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = "Toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, { description = "Close client", group = "client" }),
    awful.key(
      { modkey, "Control" },
      "space",
      awful.client.floating.toggle,
      { description = "Toggle floating", group = "client" }
    ),
    awful.key({ modkey }, "n", function(c)
      c.minimized = true
    end, { description = "Minimize", group = "client" }),

    awful.key({ modkey }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = "Toggle maximize", group = "client" })
  )

  return clientkeys
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
