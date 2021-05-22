defmenu("mainmenu", {
    menuentry("Restart", "ioncore.restart()"),
    menuentry("Reboot", "mod_query.exec_on_merr(_, 'rebooting')"),
    menuentry("Shutdown", "mod_query.exec_on_merr(_, 'shuttingdown')"),
    submenu("Styles",           "stylemenu"),
})

defctxmenu("WFrame", "Frame", {
    menuentry("Close",          "WRegion.rqclose_propagate(_, _sub)"),
    menuentry("Attach tagged", "ioncore.tagged_attach(_)", { priority = 0 }),
    menuentry("Clear tags",    "ioncore.clear_tags()", { priority = 0 }),
    menuentry("Window info",   "mod_query.show_tree(_, _sub)", { priority = 0 }),
})

defctxmenu("WGroup", "Group", {
    menuentry("Toggle tag",     "WRegion.set_tagged(_, 'toggle')"),
    menuentry("De/reattach",    "ioncore.detach(_, 'toggle')"),
})

defctxmenu("WGroupWS", "Workspace", {
    menuentry("Attach tagged",  "ioncore.tagged_attach(_)"),
})

defctxmenu("WClientWin", "Client window", {
    menuentry("Kill",           "WClientWin.kill(_)"),
})

defctxmenu("WTiling", "Tiling", {
    menuentry("Destroy frame", "WTiling.unsplit_at(_, _sub)"),
    menuentry("Untile", "mod_tiling.untile(_)"),
    submenu("Float split", {
        menuentry("At left", "WTiling.set_floating_at(_, _sub, 'toggle', 'left')"),
        menuentry("At right", "WTiling.set_floating_at(_, _sub, 'toggle', 'right')"),
        menuentry("Above", "WTiling.set_floating_at(_, _sub, 'toggle', 'up')"),
        menuentry("Below", "WTiling.set_floating_at(_, _sub, 'toggle', 'down')"),
    }),
})

defctxmenu("WFrame.floating", "Floating frame", {
    append=true,
    menuentry("New tiling", "mod_tiling.mkbottom(_)"),
})
