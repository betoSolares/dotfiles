local gears = require("gears")
local awful = require("awful")

-- Keys
local modkey = RC.vars.modkey

local _M = {}

function _M.get()
  local globalkeys = gears.table.join(
    awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "Go to previous tag", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "Go to next tag", group = "tag" }),
    awful.key({ modkey, "Control" }, "Left", function()
      awful.screen.focus_relative(-1)
    end, { description = "Focus previous screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "Right", function()
      awful.screen.focus_relative(1)
    end, { description = "Focus next screen", group = "screen" }),
    awful.key({ modkey }, "j", function()
      awful.client.focus.byidx(1)
    end, { description = "Focus next client", group = "client" }),
    awful.key({ modkey }, "k", function()
      awful.client.focus.byidx(1)
    end, { description = "Focus previous client", group = "client" }),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "Focus urgent client", group = "client" }),
    awful.key({ modkey }, "l", function()
      awful.tag.incmwfact(0.05)
    end, { description = "Increase master width", group = "layout" }),
    awful.key({ modkey }, "h", function()
      awful.tag.incmwfact(-0.05)
    end, { description = "Decrease master width", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function()
      awful.tag.incnmaster(1, nil, true)
    end, { description = "Increase master width", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function()
      awful.tag.incnmaster(-1, nil, true)
    end, { description = "Decrease master width", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function()
      awful.tag.incncol(1, nil, true)
    end, { description = "Increase master width", group = "layout" }),
    awful.key({ modkey, "Control" }, "l", function()
      awful.tag.incncol(-1, nil, true)
    end, { description = "Decrease master width", group = "layout" }),
    awful.key({ modkey }, "Tab", function()
      awful.layout.inc(1)
    end, { description = "Next layout", group = "layout" }),
    awful.key({ modkey, "Shift" }, "Tab", function()
      awful.layout.inc(-1)
    end, { description = "Previous layout", group = "layout" }),
    awful.key({}, "XF86MonBrightnessUp", function()
      awful.spawn.easy_async("brightnessctl set +5%", function() end)
    end, { description = "Brightness up", group = "hotkeys" }),
    awful.key({}, "XF86MonBrightnessDown", function()
      awful.spawn.easy_async("brightnessctl set 5%-", function() end)
    end, { description = "Brightness down", group = "hotkeys" }),
    awful.key({}, "XF86AudioRaiseVolume", function()
      awful.spawn.easy_async("pactl set-sink-volume @DEFAULT_SINK@ +5%", function() end)
    end, { description = "Audio up", group = "hotkeys" }),
    awful.key({}, "XF86AudioLowerVolume", function()
      awful.spawn.easy_async("pactl set-sink-volume @DEFAULT_SINK@ -5%", function() end)
    end, { description = "Audio down", group = "hotkeys" }),
    awful.key({}, "XF86AudioMute", function()
      awful.spawn.easy_async("pactl set-sink-mute @DEFAULT_SINK@ toggle", function() end)
    end, { description = "Toggle audio mute", group = "hotkeys" }),
    awful.key({ modkey }, "s", function()
      awful.spawn.easy_async("loginctl lock-session", function() end)
    end, { description = "Lock screen", group = "hotkeys" }),
    awful.key({ modkey, "Shift" }, "q", function()
      awful.spawn.easy_async("powermenu", function() end)
    end, { description = "Power menu", group = "hotkeys" }),
    awful.key({ modkey }, "space", function()
      awful.spawn("launcher")
    end, { description = "Launcher", group = "launcher" })
  )

  return globalkeys
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
