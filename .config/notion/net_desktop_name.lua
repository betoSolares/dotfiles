-- Simple script to make workspaces compatible with Free Desktop
-- It is a mix of statusbar wsname.lua and net_client_list.lua
-- Does it work in multi-monitor?

local atom_cardinal = ioncore.x_intern_atom("CARDINAL", false)
local atom_desktop_names = ioncore.x_intern_atom("_NET_DESKTOP_NAMES", false)
local atom_current_desktop = ioncore.x_intern_atom("_NET_CURRENT_DESKTOP", false)
local atom_number_of_desktops = ioncore.x_intern_atom("_NET_NUMBER_OF_DESKTOPS", false)
local atom_desktop_viewport = ioncore.x_intern_atom("_NET_DESKTOP_VIEWPORT", false)

local function index_of(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end

local function net_mark_supported(atom)
    if (ioncore.rootwin) then
        local rootwin = ioncore.rootwin()
        local atom_atom = ioncore.x_intern_atom("ATOM", false)
        local atom_net_supported = ioncore.x_intern_atom("_NET_SUPPORTED", false)
        ioncore.x_change_property(rootwin:xid(), atom_net_supported, atom_atom,
                                  32, "append", {atom})
    end
end

local function update_desktop_names(t)
    local reg = t["reg"]
    if not obj_is(reg, "WScreen") then
        return
    end

    local rootwin = reg:rootwin_of()
    local desktop_names = {}
    local current_desktop = 0

    local function get_values(screen)
        if screen:mx_count() == 0 then
            return
        end

        local function get_desktop_values(ws)
            local workspace_name = ws:name() or "?"
            table.insert(desktop_names, workspace_name)

            if ws == screen:mx_current() then
                current_desktop = index_of(desktop_names, workspace_name) - 1
            end

            return true
        end

        screen:mx_i(get_desktop_values)
        return true
    end

    ioncore.region_i(get_values, "WScreen")

    ioncore.defer(function()
        ioncore.x_set_utf8_property(rootwin:xid(), atom_desktop_names, desktop_names)
        ioncore.x_change_property(rootwin:xid(), atom_current_desktop, atom_cardinal,
                                  32, "replace", { current_desktop })
        ioncore.x_change_property(rootwin:xid(), atom_number_of_desktops, atom_cardinal,
                                  32, "replace", { #desktop_names })
    end)
end

do
    local hook
    hook = ioncore.get_hook("screen_managed_changed_hook")
    if hook then
        hook:add(update_desktop_names)
    end

    net_mark_supported(atom_desktop_names)
    net_mark_supported(atom_current_desktop)
    net_mark_supported(atom_number_of_desktops)
    net_mark_supported(atom_desktop_viewport)
end
