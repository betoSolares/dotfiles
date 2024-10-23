local awful = require("awful")
local beautiful = require("beautiful")

local _M = {}

function _M.get(clientkeys, clientbuttons)
  local rules = {
    {
      rule = {},
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.centered,
      },
    },
    {
      rule_any = {
        name = {
          "Event Tester",
        },
        role = {
          "pop-up",
        },
      },
      properties = {
        floating = true,
      },
    },
    {
      rule_any = {
        type = {
          "normal",
          "dialog",
        },
      },
      properties = {
        titlebars_enabled = true,
      },
    },
    {
      rule_any = { floating = true },
      properties = {
        placement = awful.placement.centered,
      },
    },
  }

  return rules
end

return setmetatable({}, {
  __call = function(_, ...)
    return _M.get(...)
  end,
})
