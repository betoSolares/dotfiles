local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local widgets = {
  taglist = require("topbar.widgets.taglist"),
  tasklist = require("topbar.widgets.tasklist"),
  separator = require("topbar.widgets.separator"),
  battery = require("topbar.widgets.battery"),
  calendar = require("topbar.widgets.calendar"),
  clock = require("topbar.widgets.clock"),
  layout = require("topbar.widgets.layout"),
  volume = require("topbar.widgets.volume"),
  brightness = require("topbar.widgets.brightness"),
  network = require("topbar.widgets.network"),
  power = require("topbar.widgets.power"),
}

local taglist_buttons = widgets.taglist()
local tasklist_buttons = widgets.tasklist()
local separator = widgets.separator()
local calendar = widgets.calendar()
local clock = widgets.clock()
local battery = widgets.battery()
local volume = widgets.volume()
local brightness = widgets.brightness()
local network = widgets.network()
local power = widgets.power()

awful.screen.connect_for_each_screen(function(s)
  s.taglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  })

  s.tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  })

  local layoutbox = widgets.layout(s)

  s.wibox = awful.wibar({ position = "top", screen = s, height = dpi(35) })

  s.wibox:setup({
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      power,
      separator,
      s.taglist,
      separator,
    },
    s.tasklist,
    {
      layout = wibox.layout.fixed.horizontal,
      separator,
      wibox.widget.systray(),
      separator,
      network,
      separator,
      brightness,
      separator,
      volume,
      separator,
      battery,
      separator,
      calendar,
      separator,
      clock,
      separator,
      layoutbox,
    },
  })
end)
