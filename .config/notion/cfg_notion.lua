-- Notion main configuration file

META="Mod4+"
ALTMETA="Mod4+Shift+"

-- Some basic settings.
ioncore.set{
    dblclick_delay=250,
    kbresize_delay=1500,
    opaque_resize=true,
    warp=false,
    screen_notify=true,
    unsqueeze=false,
    autosave_layout=false,
    mousefocus="disabled",
    activity_notification_on_all_screens=true,
    workspace_indicator_timeout=0,
}

dopath("cfg_defaults")
dopath("autostart")
