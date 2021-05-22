defbindings("WScreen", {
    kpress(META.."1", "WScreen.switch_nth(_, 0)"),
    kpress(META.."2", "WScreen.switch_nth(_, 1)"),
    kpress(META.."3", "WScreen.switch_nth(_, 2)"),
    kpress(META.."4", "WScreen.switch_nth(_, 3)"),
    kpress(META.."5", "WScreen.switch_nth(_, 4)"),
    kpress(META.."6", "WScreen.switch_nth(_, 5)"),
    kpress(META.."Right", "WScreen.switch_next(_)"),
    kpress(META.."Left", "WScreen.switch_prev(_)"),
    kpress(META.."l", "ioncore.goto_next(_chld, 'right')"),
    kpress(META.."h", "ioncore.goto_next(_chld, 'left')"),
    kpress(META.."k", "ioncore.goto_next(_chld, 'up')"),
    kpress(META.."j", "ioncore.goto_next(_chld, 'down')"),
    kpress(META.."g", "mod_menu.grabmenu(_, _sub, 'focuslist')"),
    kpress("Print", "mod_query.exec_on_merr(_, 'flameshot gui')"),
    kpress(META.."r", "ioncore.restart()"),
    kpress(ALTMETA.."q", "mod_query.exec_on_merr(_, 'shuttingdown')"),
    kpress(ALTMETA.."r", "mod_query.exec_on_merr(_, 'rebooting')"),
    kpress(ALTMETA.."t", "ioncore.tagged_clear()"),
})

defbindings("WClientWin", {
    kpress(ALTMETA.."c", "WClientWin.kill(_)"),
})

defbindings("WGroupCW", {
    kpress_wait(META.."F11", "WGroup.set_fullscreen(_, 'toggle')"),
})

defbindings("WMPlex", {
    kpress(ALTMETA.."d", "ioncore.detach(_chld, 'toggle')", "_chld:non-nil"),
})

defbindings("WMPlex.toplevel", {
    -- Applications
    kpress(META.."t", "WRegion.set_tagged(_sub, 'toggle')", "_sub:non-nil"),
    kpress(META.."Return", "mod_query.exec_on_merr(_, 'st')"),
    kpress(META.."b", "mod_query.exec_on_merr(_, 'chromium')"),
    kpress(ALTMETA.."b", "mod_query.exec_on_merr(_, 'chromium --incognito')"),
    kpress(META.."d", "mod_query.exec_on_merr(_, 'dmenurun')"),
    kpress(META.."q", "mod_query.exec_on_merr(_, 'qute')"),
    kpress(META.."e", "mod_query.exec_on_merr(_, 'dmenuunicode')"),
    kpress(ALTMETA.."e", "mod_query.exec_on_merr(_, 'dmenukaomoji')"),
    kpress(ALTMETA.."w", "mod_query.exec_on_merr(_, 'wpa-cute')"),
    kpress(META.."v", "mod_query.exec_on_merr(_, 'st -e vim')"),
    kpress(META.."f", "mod_query.exec_on_merr(_, 'st -e ranger')"),
    kpress(META.."w", "mod_query.exec_on_merr(_, 'st -e weechat')"),
    kpress(META.."n", "mod_query.exec_on_merr(_, 'st -e neomutt')"),
    kpress(ALTMETA.."m", "mod_query.exec_on_merr(_, 'dmenumount')"),
    kpress(ALTMETA.."u", "mod_query.exec_on_merr(_, 'dmenuunmount')"),
    kpress(META.."F8", "mod_query.exec_on_merr(_, 'recorder')"),
    kpress("F1", "mod_query.exec_on_merr(_, '/dev/null')"),

    -- Audio
    kpress("XF86AudioLowerVolume", "mod_query.exec_on_merr(_, 'pactl set-sink-volume 0 -1%')"),
    kpress("XF86AudioRaiseVolume", "mod_query.exec_on_merr(_, 'pactl set-sink-volume 0 +1%')"),
    kpress("XF86AudioMute", "mod_query.exec_on_merr(_, 'pactl set-sink-mute 0 toggle')"),

    -- Backlight
    kpress("XF86MonBrightnessDown", "mod_query.exec_on_merr(_, 'xbacklight -dec 1')"),
    kpress("XF86MonBrightnessUp", "mod_query.exec_on_merr(_, 'xbacklight -inc 1')"),
})

defbindings("WFrame", {
    kpress(META.."u", "WFrame.maximize_horiz(_)"),
    kpress(META.."p", "WFrame.maximize_horiz(_)"),
    kpress(META.."o", "WFrame.maximize_vert(_)"),
    kpress(META.."i", "WFrame.maximize_vert(_)"),
    kpress(META.."m", "WFrame.begin_kbresize(_)"),
    kpress(META.."Tab", "WFrame.switch_next(_)"),
    kpress(ALTMETA.."Tab", "WFrame.switch_prev(_)"),
})

defbindings("WFrame.toplevel", {
    kpress(ALTMETA.."a", "ioncore.tagged_attach(_)"),
    kpress(META.."comma", "WFrame.dec_index(_, _sub)", "_sub:non-nil"),
    kpress(META.."period", "WFrame.inc_index(_, _sub)", "_sub:non-nil"),
    kpress(META.."u", "WFrame.maximize_horiz(_)"),
    kpress(META.."p", "WFrame.maximize_horiz(_)"),
    kpress(META.."o", "WFrame.maximize_vert(_)"),
    kpress(META.."i", "WFrame.maximize_vert(_)"),
    kpress(ALTMETA.."g", "WFrame.set_numbers(_, 'during_grab')"),
    submap(ALTMETA.."g", {
        bdoc("Switch to n:th object within the frame."),
        kpress("1", "WFrame.switch_nth(_, 0)"),
        kpress("2", "WFrame.switch_nth(_, 1)"),
        kpress("3", "WFrame.switch_nth(_, 2)"),
        kpress("4", "WFrame.switch_nth(_, 3)"),
        kpress("5", "WFrame.switch_nth(_, 4)"),
        kpress("6", "WFrame.switch_nth(_, 5)"),
        kpress("7", "WFrame.switch_nth(_, 6)"),
        kpress("8", "WFrame.switch_nth(_, 7)"),
        kpress("9", "WFrame.switch_nth(_, 8)"),
        kpress("0", "WFrame.switch_nth(_, 9)"),
    }),
})

defbindings("WFrame.floating", {
    kpress(ALTMETA.."space", "mod_tiling.mkbottom(_)"),
})

defbindings("WMoveresMode", {
    kpress("AnyModifier+Escape","WMoveresMode.cancel(_)"),
    kpress("AnyModifier+Return","WMoveresMode.finish(_)"),
    kpress("Left",  "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("Right", "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("Up",    "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("Down",  "WMoveresMode.resize(_, 0, 0, 0, 1)"),
    kpress("h",     "WMoveresMode.resize(_, 1, 0, 0, 0)"),
    kpress("l",     "WMoveresMode.resize(_, 0, 1, 0, 0)"),
    kpress("k",     "WMoveresMode.resize(_, 0, 0, 1, 0)"),
    kpress("j",     "WMoveresMode.resize(_, 0, 0, 0, 1)"),
    kpress("Shift+Left",  "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Shift+Right", "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Shift+Up",    "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Shift+Down",  "WMoveresMode.resize(_, 0, 0, 0,-1)"),
    kpress("Shift+h",     "WMoveresMode.resize(_,-1, 0, 0, 0)"),
    kpress("Shift+l",     "WMoveresMode.resize(_, 0,-1, 0, 0)"),
    kpress("Shift+k",     "WMoveresMode.resize(_, 0, 0,-1, 0)"),
    kpress("Shift+j",     "WMoveresMode.resize(_, 0, 0, 0,-1)"),
    kpress(META.."Left",  "WMoveresMode.move(_,-1, 0)"),
    kpress(META.."Right", "WMoveresMode.move(_, 1, 0)"),
    kpress(META.."Up",    "WMoveresMode.move(_, 0,-1)"),
    kpress(META.."Down",  "WMoveresMode.move(_, 0, 1)"),
    kpress(META.."h",     "WMoveresMode.move(_,-1, 0)"),
    kpress(META.."l",     "WMoveresMode.move(_, 1, 0)"),
    kpress(META.."k",     "WMoveresMode.move(_, 0,-1)"),
    kpress(META.."j",     "WMoveresMode.move(_, 0, 1)"),
})

defbindings("WTiling", {
    kpress(ALTMETA.."h", "WTiling.split_at(_, _sub, 'left', false)"),
    kpress(ALTMETA.."l", "WTiling.split_at(_, _sub, 'right', false)"),
    kpress(ALTMETA.."k", "WTiling.split_at(_, _sub, 'top', false)"),
    kpress(ALTMETA.."j", "WTiling.split_at(_, _sub, 'bottom', false)"),
    kpress(META.."space", "WTiling.set_floating_at(_, _sub, 'toggle', 'any')"),
    kpress(ALTMETA.."c", "WTiling.unsplit_at(_, _sub)"),
})
