# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Imports
import os
import subprocess
from libqtile.config import Drag, Click, Key, Group, Screen
from libqtile.command import lazy
from libqtile import bar, hook, layout, widget
from customWidgets import Script
import json

mod = "mod4"

# Personalize functions
@lazy.function
def to_next_group(qtile):
    if qtile.currentWindow is not None:
        index = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[index + 1].name)

@lazy.function
def to_prev_group(qtile):
    if qtile.currentWindow is not None:
        index = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[index - 1].name)

@lazy.function
def changebrightnessup(qtile):
        subprocess.call(['sh', '/home/beto/bin/tools/backlightup'])

@lazy.function
def changebrightnessdown(qtile):
        subprocess.call(['sh', '/home/beto/bin/tools/backlightdown'])

@lazy.function
def screenshot(qtile):
        subprocess.call(['sh', '/home/beto/bin/tools/screenshot'])

# Read colors from wal
with open("/home/beto/.cache/wal/colors.json") as f:
    colors = json.load(f)['colors']

# Keybandings
keys = [
    # Applications
    Key([mod], "Return", lazy.spawn("st")),
    Key([mod], "v", lazy.spawn("vivaldi-stable")),
    Key([mod, "control"], "v", lazy.spawn("vivaldi-stable --incognito")), 
    Key([mod], "d", lazy.spawn("dmenurun")), 
    Key([mod], "q", lazy.spawn("qute")),

    # Audio Control
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -1%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +1%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle")),

    # Backlight Control
    Key([], "XF86MonBrightnessDown", changebrightnessdown),
    Key([], "XF86MonBrightnessUp", changebrightnessup), 

    # ScreenShot
    Key([], "Print", screenshot),

    # System Control
    Key([mod, "shift"], "q", lazy.spawn("shuttingdown")),
    Key([mod, "shift"], "r", lazy.spawn("rebooting")),

    # Window Controls
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()), 
    Key([mod], "l", lazy.layout.right()),
    Key([mod, "shift"], "h", lazy.layout.shrink()), 
    Key([mod, "shift"], "l", lazy.layout.grow()),
    Key([mod], "o", lazy.layout.normalize()), 
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "Left", lazy.screen.prev_group()),
    Key([mod], "Right", lazy.screen.next_group()),
    Key([mod, "shift"], "Left", to_prev_group),
    Key([mod, "shift"], "Right", to_next_group),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),
    Key([mod], "b", lazy.hide_show_bar()), 
    Key([mod, "shift"], "c", lazy.window.kill()),
    Key([mod], "r", lazy.restart()),
]

# Mouse bindings 
mouse = [
   # Window Control
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
    Click([mod, "shift"], "Button2", lazy.window.kill()),
]

# Common properties in layouts
commonProperties = dict(
    border_focus = colors['color2'], 
    border_normal = colors['color0'], 
    border_width = 2, 
    margin = 6, 
)

# Layouts
layouts = [
    layout.MonadTall(**commonProperties, name = "﬿"), 
    layout.MonadWide(**commonProperties, name = "ﰧ"), 
    layout.Columns(insert_position = 1, fair = True, num_columns=3, **commonProperties, name = "﩯"),
    layout.Max(name = ""),
    layout.Floating(**commonProperties, name = ""), 
]

# Groups
groups = [
    Group(name = "", layout = ""),
    Group(name = "ﲵ", layout = "﬿"),
    Group(name = "", layout = "﬿"),
    Group(name = "", layout = ""),
    Group(name = "", layout = "﩯"), 
    Group(name = "", layout = ""), 
    Group(name = "", layout = ""), 
    Group(name = "", layout = "﩯"), 
    Group(name = "", layout = ""),
    Group(name = "", layout = "﬿")
]

# Keybandings to change the group
for index, group in enumerate(groups[:10]):
    i = 0 if index == 9 else index + 1  
    keys.append(Key([mod], str(i), lazy.group[group.name].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(group.name)))

# Screen, bar and widgets
screens = [
    Screen(
        top = bar.Bar([
            widget.GroupBox(
               active = colors['color0'],
               borderwidth = 2,
               fontsize = 20,
               foreground = colors['color0'],
               highlight_color = [colors['color1'], colors['color1']],
               highlight_method = "line",
               inactive = colors['color7'],
               padding = 0,
               margin_x = 0,
               margin_y = 0,
               this_current_screen_border = colors['color0']
            ),
            widget.Sep( foreground = colors['color1']),
            widget.Sep( foreground = colors['color7'], size_percent = 70),
            widget.CurrentLayout(
                font = "monospace",
                fontsize = 15,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Sep( foreground = colors['color7'], size_percent = 70),
            widget.WindowName(
                font = "monospace",
                fontsize = 10,
                foreground = colors['color1'],
                padding = 0
            ),
            widget.Systray(
                icon_size = 15,
                padding = 5,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Sep( foreground = colors['color1']),
            widget.TextBox(
                text = "",
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.ThermalSensor(
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.TextBox(
                text = "",
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            Script(
                name = "memory",
                update_interval = 1,
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.TextBox(
                text = "",
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Pacman(
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                unavailable = colors['color7'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.TextBox(
                text = "/",
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                padding = 0,
                margin_x = 0,
                margin_y = 0
            ),
            Script(
                name = "aurupdates",
                update_interval = 60,
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.TextBox(
                    text = "盛",
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            Script(
                name = "backlight",
                update_interval = 1,
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            Script(
                name = "iconvolume",
                update_interval = 1,
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            Script(
                name = "volume",
                update_interval = 1,
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.TextBox(
                text = "",
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Wlan(
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                format = "{essid}",
                interface = "wlo1",
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
             Script(
                name = "iconbattery",
                update_interval = 1,
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            Script(
                name = "battery",
                update_interval = 60,
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.TextBox(
                text = "",
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Clock(
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                format = "%b %d (%a)",
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.TextBox(
                text = "",
                font = "monospace",
                fontsize = 16,
                foreground = colors['color0'],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Clock(
                font = "monospace",
                fontsize = 10,
                foreground = colors['color7'],
                format = "%I:%M",
                padding = 3,
                margin_x = 0,
                margin_y = 0
            )
        ], 20, background = colors['color1'])
    )
]

# Variables
auto_fullscreen = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
focus_on_window_activation = "smart"
follow_mouse_focus = False
main = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
#wmname = "LG3D"
wmname = "Qtile"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/bin/wm/autostart')
    subprocess.call(['sh', home])

