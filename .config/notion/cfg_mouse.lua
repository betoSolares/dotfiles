defbindings("WScreen", {
    mpress("Button3", "mod_menu.pmenu(_, _sub, 'mainmenu')"),
    mpress("Button2", "mod_menu.pmenu(_, _sub, 'windowlist')"),
})

defbindings("WFrame", {
    mpress("Button3", "mod_menu.pmenu(_, _sub, 'ctxmenu')"),
    mclick("Button1@tab", "WFrame.p_switch_tab(_)"),
    mclick("Button2@tab", "WFrame.p_switch_tab(_)"),
    mdrag("Button1@border", "WFrame.p_resize(_)"),
    mdrag(META.."Button3", "WFrame.p_resize(_)"),
    mdrag(META.."Button1", "WFrame.p_move(_)"),
    mdrag("Button1@tab", "WFrame.p_tabdrag(_)"),
    mdrag("Button2@tab", "WFrame.p_tabdrag(_)"),
    mclick(META.."Button4", "WFrame.switch_next(_)"),
    mclick(META.."Button5", "WFrame.switch_prev(_)"),
})

defbindings("WFrame.floating", {
    mdblclick("Button1@tab", "WFrame.set_shaded(_, 'toggle')"),
    mpress("Button1@tab", "WRegion.rqorder(_, 'front')"),
    mpress("Button1@border", "WRegion.rqorder(_, 'front')"),
    mclick(META.."Button1", "WRegion.rqorder(_, 'front')"),
    mclick(META.."Button3", "WRegion.rqorder(_, 'back')"),
    mdrag("Button1@tab", "WFrame.p_move(_)"),
})

defbindings("WTiling", {
    mclick(META.."Shift+Button4", "ioncore.goto_next(_sub, 'up', {no_ascend=_})"),
    mclick(META.."Shift+Button5", "ioncore.goto_next(_sub, 'down', {no_ascend=_})"),
})
