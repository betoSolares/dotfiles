from libqtile.config import Drag, Click, Key 
from libqtile.command import lazy
from groups import groups

mod = "mod4"

# Mouse bindings 
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
    Click([mod, "shift"], "Button2", lazy.window.kill()),
]

# Keybandings
keys = [
    # Applications
    Key([mod], "Return", lazy.spawn("st")),
    Key([mod], "v", lazy.spawn("vivaldi-stable")),
    Key([mod, "shift"], "v", lazy.spawn("vivaldi-stable --incognito")), 
    Key([mod], "d", lazy.spawn("dmenurun")), 
    Key([mod, "control"], "r", lazy.spawn("rofi -show run")), 
    Key([mod], "q", lazy.spawn("qute")),
    Key([mod], "e", lazy.spawn("rofiunicode")),
    Key([mod, "shift"], "e", lazy.spawn("rofikaomoji")),
    Key([mod], "w", lazy.spawn("dmenuwifi")),

    # Audio Control
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q -c 1 sset Master 1%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q -c 1 sset Master 1%+")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q -c 1 sset Master toggle")),

    # Backlight Control
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 1")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 1")), 

    # ScreenShot
    Key([], "Print", lazy.spawn("screenshot")),

    # System Control
    Key([mod, "shift"], "q", lazy.spawn("shuttingdown")),
    Key([mod, "shift"], "r", lazy.spawn("rebooting")),
    Key([mod], "r", lazy.restart()),
    Key([mod], "Left", lazy.screen.prev_group()),
    Key([mod], "Right", lazy.screen.next_group()),

    # Window Controls
    Key([mod], "F11", lazy.window.toggle_fullscreen()),
    Key([mod], "b", lazy.hide_show_bar()), 
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),
    Key([mod, "shift"], "c", lazy.window.kill()),

    #ScratchPad
    Key([mod, "shift"], "d", lazy.group["ScratchPad"].dropdown_toggle("term")),
    
    # Layout Controls
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod, "shift"], "h", lazy.layout.swap_left(), lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right(), lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod], "p", lazy.layout.grow(), lazy.layout.grow_right()),
    Key([mod], "u", lazy.layout.shrink(), lazy.layout.grow_left()),
    Key([mod], "o", lazy.layout.grow_up()),
    Key([mod], "i", lazy.layout.grow_down()),
    Key([mod], "space", lazy.layout.flip()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
]

# Keybandings to change the group
for index, group in enumerate(groups[:10]):
    i = 0 if index == 9 else index + 1  
    keys.append(Key([mod], str(i), lazy.group[group.name].toscreen()))
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(group.name)))

