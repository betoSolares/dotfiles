from libqtile import bar, widget
from customWidgets import Script
from colors import colors

bar = bar.Bar([
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
    widget.Spacer(length = 5),
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
        fontsize = 12,
        foreground = colors['color7'],
        padding = 5
    ),
    widget.Systray(
        icon_size = 15,
        padding = 5,
        margin_x = 0,
        margin_y = 0
    ),
    widget.Mpd(
        do_color_progress = True,
        fmt_playing = " %f",
        fmt_stopped = "",
        font = "monospace",
        padding = 3,
        margin_x = 0,
        margin_y = 0
    ),
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
    widget.CheckUpdates(
        font = "monospace",
        fontsize = 10,
        foreground = colors['color7'],
        colour_have_updates = colors['color7'],
        colour_no_updates = colors['color7'],
        distro = "Arch",
        display_format = "{updates}",
        update_interval = 10,
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
    widget.CheckUpdates(
        font = "monospace",
        fontsize = 10,
        foreground = colors['color7'],
        colour_have_updates = colors['color7'],
        colour_no_updates = colors['color7'],
        custom_command = "checkupdates-aur",
        display_format = "{updates}",
        update_interval = 10,
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
    widget.Backlight(
        backlight_name = "intel_backlight",
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
    widget.Battery(
        baterry = 0,
        font = "monospace",
        fontsize = 10,
        foreground = colors['color7'],
        low_foreground = colors['color7'],
        format = "{percent:2.0%}",
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
