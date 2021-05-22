defbindings("WMenu", {
    kpress("Escape", "WMenu.cancel(_)"),
    kpress("Control+C", "WMenu.cancel(_)"),
    kpress("Return",  "WMenu.finish(_)"),
    kpress("KP_Enter", "WMenu.finish(_)"),
    kpress("Up", "WMenu.select_prev(_)"),
    kpress("Down", "WMenu.select_next(_)"),
    kpress("k", "WMenu.select_prev(_)"),
    kpress("j", "WMenu.select_next(_)"),
    kpress("BackSpace", "WMenu.typeahead_clear(_)"),
})
