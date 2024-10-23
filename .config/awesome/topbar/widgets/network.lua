local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local color = require("topbar.colors")

local _M = {}

function _M.get()
  local network = wibox.widget({
    markup = '<span color="' .. color.fg_focus .. '" font="GoMono Nerd Font 12">󱚼 </span>',
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  })

  local function update_widget()
    awful.spawn.easy_async_with_shell(
      "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2 | tr -d '\n'",
      function(stdout, _, _, _)
        local net_icon
        local net_text
        local wifi = stdout:gsub("[\n\r]", "")

        if wifi == nil or wifi == "" then
          net_icon = "󱚵 "
          net_text = ""
        else
          net_icon = "󰖩 "
          net_text = wifi
        end

        local icon = '<span color="' .. color.fg_focus .. '" font="GoMono Nerd Font 12">' .. net_icon .. "</span>"
        local text = '<span color="' .. color.fg_normal .. '" font="GoMono Nerd Font 12">' .. net_text .. "</span>"

        network.markup = icon .. text
      end
    )
  end

  network:buttons(awful.util.table.join(awful.button({}, 1, function()
    awful.spawn("alacritty -e bash -c nmtui")
  end)))

  gears.timer({
    timeout = 10,
    call_now = true,
    autostart = true,
    callback = function()
      update_widget()
    end,
  })

  return network
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
