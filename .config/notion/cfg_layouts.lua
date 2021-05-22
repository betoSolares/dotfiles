local a_frame = {
    type="WSplitRegion",
    regparams = {
        type = "WFrame",
        frame_style = "frame-tiled"
    }
}

local function mktiling(split_tree)
    return {
        managed = {
            {
                type = "WTiling",
                bottom = true, -- Make it the bottom of the group.
                split_tree = split_tree,
            }
        }
    }
end

ioncore.deflayout("full", mktiling(a_frame))
