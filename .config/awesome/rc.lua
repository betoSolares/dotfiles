-- Use LuaRocks packages
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")

-- Set default variables
RC = {}
RC.vars = require("main.variables")

-- Handle errors
require("main.errors")

-- Load theme
require("theme")

-- Layouts, tags and rules
local main = {
  layouts = require("main.layouts"),
  tags = require("main.tags"),
  rules = require("main.rules"),
}

RC.layouts = main.layouts()
RC.tags = main.tags()

-- Keys and Mouse Binding
local bindings = {
  globalbuttons = require("bindings.global_buttons"),
  clientbuttons = require("bindings.client_buttons"),
  globalkeys = require("bindings.global_keys"),
  tagkeys = require("bindings.tag_keys"),
  clientkeys = require("bindings.client_keys"),
}

RC.globalkeys = bindings.globalkeys()
RC.globalkeys = bindings.tagkeys(RC.globalkeys)

root.buttons(bindings.globalbuttons())
root.keys(RC.globalkeys)

--Notifications
require("notifications.notifications")

-- Rules to apply to new clients
awful.rules.rules = main.rules(bindings.clientkeys(), bindings.clientbuttons())

-- Topbar
require("topbar.topbar")

-- Signals
require("main.signals")

-- autostart
awful.spawn("blueman-applet")
awful.spawn("flameshot")
awful.spawn.with_shell(
  [[sleep 1s && xss-lock --transfer-sleep-lock -- i3lock -n -e -t -i ~/.config/awesome/theme/wallpaper.png]]
)
