from libqtile.config import DropDown, Group, ScratchPad

# Groups
groups = [
    Group(name = "", layout = ""),
    Group(name = "ﲵ", layout = "﬿"),
    Group(name = "", layout = "﬿"),
    Group(name = "曆", layout = ""),
    Group(name = "", layout = "﩯"), 
    Group(name = "", layout = ""), 
    Group(name = "", layout = ""), 
    Group(name = "", layout = "﩯"), 
    Group(name = "", layout = ""),
    Group(name = "", layout = "﬿")
]

# DropDown terminal
groups.append(
    ScratchPad("ScratchPad", [
        DropDown("term", "st", opacity=0.9, x=0.25, y=0.25, width=0.5, height=0.5)
    ])
)

