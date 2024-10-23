local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local dir = os.getenv("HOME") .. "/.config/awesome/theme"

local mocha = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#171717",
  mantle = "#171717",
  crust = "#121212",
}

local theme = {}

mocha.yellow = mocha.yellow
mocha.orange = mocha.peach
mocha.purple = mocha.mauve
mocha.green = mocha.green
mocha.black = mocha.base
mocha.white = mocha.text
mocha.pink = mocha.pink
mocha.blue = mocha.blue
mocha.grey = mocha.surface0
mocha.red = mocha.red
mocha.fg = mocha.white
mocha.bg = mocha.black

theme.colors = mocha
theme.colors.accent = theme.colors.purple
theme.colors.prominent = theme.colors.orange
theme.colors.bg_normal = theme.colors.bg
theme.colors.fg_normal = theme.colors.fg
theme.colors.bg_focus = theme.colors.bg
theme.colors.fg_focus = theme.colors.accent
theme.colors.bg_error = theme.colors.red
theme.colors.fg_error = theme.colors.fg

local color = theme.colors

theme.font = "GoMono Nerd Font 12"

theme.bg_normal = color.bg_normal
theme.bg_focus = color.bg_focus
theme.bg_urgent = color.bg_error

theme.fg_normal = color.fg_normal
theme.fg_focus = color.fg_focus
theme.fg_urgent = color.fg_error

theme.bg_systray = color.bg_normal

theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.tasklist_bg_minimize = color.bg_focus
theme.tasklist_bg_focus = color.grey

theme.taglist_spacing = dpi(3)
theme.taglist_squares_sel = dir .. "/icons/taglist/square_sel.png"
theme.taglist_squares_unsel = dir .. "/icons/taglist/square_unsel.png"
theme.taglist_bg_focus = color.bg_normal
theme.taglist_fg_focus = color.accent
theme.taglist_bg_occupied = color.bg_normal
theme.taglist_fg_occupied = color.overlay1
theme.taglist_bg_empty = color.bg_normal
theme.taglist_fg_empty = color.surface0
theme.taglist_bg_urgent = color.bg_normal
theme.taglist_fg_urgent = color.fg_error
theme.taglist_bg_volatile = color.bg_normal
theme.taglist_fg_volatile = color.fg_error

theme.useless_gap = dpi(4)
theme.border_width = dpi(1)
theme.border_normal = color.grey
theme.border_focus = color.accent
theme.border_marked = color.prominent

theme.wibar_bg_normal = color.bg_normal

theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus

theme.titlebar_close_button_focus = dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_normal_hover = dir .. "/icons/titlebar/close_normal_hover.png"
theme.titlebar_close_button_focus_hover = dir .. "/icons/titlebar/close_normal_hover.png"

theme.titlebar_maximized_button_normal_inactive = dir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_inactive_hover = dir .. "/icons/titlebar/maximized_normal_inactive_hover.png"
theme.titlebar_maximized_button_focus_inactive_hover = dir .. "/icons/titlebar/maximized_focus_inactive_hover.png"
theme.titlebar_maximized_button_normal_active_hover = dir .. "/icons/titlebar/maximized_normal_active_hover.png"
theme.titlebar_maximized_button_focus_active_hover = dir .. "/icons/titlebar/maximized_focus_active_hover.png"

theme.titlebar_minimize_button_normal = dir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = dir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_minimize_button_normal_hover = dir .. "/icons/titlebar/minimize_normal_hover.png"
theme.titlebar_minimize_button_focus_hover = dir .. "/icons/titlebar/minimize_focus_hover.png"

theme.titlebar_sticky_button_normal_inactive = dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = dir .. "/icons/titlebar/sticky_focus_active.png"

theme.layout_tile = dir .. "/icons/layouts/tile.png"
theme.layout_floating = dir .. "/icons/layouts/floating.png"

theme.notification_font = "GoMono Nerd Font"
theme.notification_bg = color.prominent
theme.notification_fg = color.bg
theme.notification_error_bg = color.red
theme.notification_error_fg = color.fg_normal
theme.notification_border_width = dpi(0)
theme.notification_margin = dpi(10)

theme.wallpaper = dir .. "/wallpaper.png"
gears.wallpaper.maximized(theme.wallpaper)

return theme
