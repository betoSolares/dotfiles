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
from libqtile.config import Drag, Click, Key, Group, Screen
from libqtile.command import lazy
from libqtile import bar, layout, widget
from customWidgets import Script

mod = "mod4"

# Read colors from .Xresources
colors = []
with open("/home/beto/.Xresources") as xres:
    for i, line in enumerate(xres):
        if i >= 20 and i <= 51:
            if i % 2 == 0:
                colors.append(line[line.find("#") + 1:].rstrip())

# Keybandings
keys = [
    # Applications
    Key([mod], "Return", lazy.spawn("st")),
    Key([mod], "v", lazy.spawn("vivaldi-stable")),
    Key([mod, "control"], "v", lazy.spawn("vivaldi-stable --incognito")), 
    Key([mod], "d", lazy.spawn("dmenu_run")), 

    # Audio Control
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -1%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +1%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle")),

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
    Key([mod, "shift"], "Tab", lazy.prev_layout()),
    Key([mod], "b", lazy.hide_show_bar()), 
    Key([mod, "shift"], "c", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
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
    border_focus = colors[2], 
    border_normal = colors[0], 
    border_width = 2, 
    margin = 6, 
)

# Layouts
layouts = [
    layout.MonadTall(**commonProperties), 
    layout.MonadWide(**commonProperties), 
    layout.Columns(insert_position = 1, fair = True, num_columns=3, **commonProperties),
    layout.Max(),
    layout.Floating(**commonProperties), 
]

# Groups
groups = [
    Group(name = "WWW", layout = "max"),
    Group(name = "DEV", layout = "monadtall"),
    Group(name = "TXT", layout = "monadtall"),
    Group(name = "VM", layout = "floating"),
    Group(name = "AUDIO", layout = "columns"), 
    Group(name = "VIDEO", layout = "max"), 
    Group(name = "GAMES", layout = "floating"), 
    Group(name = "CHAT", layout = "columns"), 
    Group(name = "MEDIA", layout = "floating"),
    Group(name = "SYS", layout = "monadtall")
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
               active = colors[0],
               borderwidth = 2,
               font = "monospace",
               fontsize = 10,
               foreground = colors[0],
               highlight_color = [colors[1], colors[1]],
               highlight_method = "line",
               inactive = colors[7],
               padding = 0,
               margin_x = 0,
               margin_y = 0,
               this_current_screen_border = colors[0]
            ),
            widget.Sep( foreground = colors[1]),
            widget.Sep( foreground = colors[7], size_percent = 70),
            widget.CurrentLayoutIcon(
                font = "monospace",
                fontsize = 10,
                foreground = colors[0],
                padding = 3,
                margin_x = 0,
                margin_y = 0,
                scale = 1
            ),
            widget.Sep( foreground = colors[7], size_percent = 70),
            widget.WindowName(
                font = "monospace",
                fontsize = 10,
                foreground = colors[1],
                padding = 0
            ),
            widget.Systray(
                padding = 3,
                margin_x = 0,
                margin_y = 0,
                icon_size = 15
            ),
            widget.Pacman(
                font = "monospace",
                fontsize = 10,
                foregorund = colors[7],
                unavailable = colors[7],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            # Updates
            # Backlight
            #widget.Volume(
            #    font = "monospace",
            #    fontsize = 10,
            #    foreground = "dd1616",
            #    device = "hw: 1",
            #    step = 1,
            #    padding = 3,
            #    margin_x = 0,
            #    margin_y = 0
            #),
            widget.Wlan(
                font = "monospace",
                fontsize = 10,
                foreground = colors[7],
                format = "{essid} {percent:2.0%}",
                interface = "wlo1",
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Battery(
                charge_char = "C",
                discharge_char = "M",
                font = "monospace",
                fontsize = 10,
                foreground = colors[7],
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Clock(
                font = "monospace",
                fontsize = 10,
                foreground = colors[7],
                format = "%b %d (%a)",
                padding = 3,
                margin_x = 0,
                margin_y = 0
            ),
            widget.Clock(
                font = "monospace",
                fontsize = 10,
                foreground = colors[7],
                format = "%H:%M",
                padding = 3,
                margin_x = 0,
                margin_y = 0
            )
        ], 20, background = colors[1])
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

