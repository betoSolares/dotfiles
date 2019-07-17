from libqtile import layout
from colors import colors

commonProperties = dict(
    border_focus = colors['color2'], 
    border_normal = colors['color0'], 
    border_width = 2, 
    margin = 6, 
)

layouts = [
    layout.MonadTall(**commonProperties, name = "﬿"), 
    layout.MonadWide(**commonProperties, name = ""), 
    layout.Columns(insert_position = 1, fair = True, num_columns=3, **commonProperties, name = "﩯"),
    layout.Max(name = ""),
    layout.Floating(**commonProperties, name = ""), 
]
