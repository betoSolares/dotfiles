local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local color = require("topbar.colors")
local naughty = require("naughty")

local _M = {}

function _M.get()
  local function show_battery_warning()
    naughty.notify({
      text = "Battery is dying",
      title = "Battery",
      timeout = 25,
      hover_timeout = 0.5,
      screen = mouse.screen,
    })
  end

  local notification
  local function show_battery_status()
    awful.spawn.easy_async([[bash -c 'acpi']], function(stdout, _, _, _)
      naughty.destroy(notification)
      notification = naughty.notify({
        text = stdout,
        title = "Battery status",
        timeout = 5,
        hover_timeout = 0.5,
        screen = mouse.screen,
      })
    end)
  end

  local battery = wibox.widget({
    markup = "",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
  })

  local timeout = 10
  local last_battery_check = os.time()
  local batteryIcon = ""

  watch("acpi -i", timeout, function(widget, stdout)
    local battery_info = {}
    local capacities = {}

    for s in stdout:gmatch("[^\r\n]+") do
      local status, charge_str, _ = string.match(s, ".+: ([%a%s]+), (%d?%d?%d)%%,?(.*)")
      if status ~= nil then
        table.insert(battery_info, { status = status, charge = tonumber(charge_str) })
        table.insert(capacities, 0)
      end

      local cap_str = string.match(s, ".+:.+last full capacity (%d+)")
      if cap_str ~= nil then
        capacities[#capacities] = tonumber(cap_str) or 0
      end
    end

    local capacity = 0
    local charge = 0
    local status

    for i, batt in ipairs(battery_info) do
      if capacities[i] ~= nil then
        if batt.charge >= charge then
          status = batt.status
        end

        charge = charge + batt.charge * capacities[i]
        capacity = capacity + capacities[i]
      end
    end

    charge = charge / capacity

    if charge >= 1 and charge < 15 then
      batteryIcon = "󰂎 "

      if status ~= "Charging" and os.difftime(os.time(), last_battery_check) > 300 then
        last_battery_check = os.time()

        show_battery_warning()
      end
    elseif charge >= 15 and charge < 40 then
      batteryIcon = "󰁼 "
    elseif charge >= 40 and charge < 60 then
      batteryIcon = "󰁾 "
    elseif charge >= 60 and charge < 80 then
      batteryIcon = "󰂀 "
    elseif charge >= 80 and charge <= 100 then
      batteryIcon = "󰁹 "
    end

    if status == "Charging" then
      batteryIcon = "󰂄 "
    end

    local icon = '<span color="' .. color.fg_focus .. '" font="GoMono Nerd Font 12">' .. batteryIcon .. "</span>"
    local text = '<span color="'
      .. color.fg_normal
      .. '" font="GoMono Nerd Font 12">'
      .. string.format("%d%%", charge)
      .. " </span>"

    widget.markup = icon .. text
  end, battery)

  battery:connect_signal("mouse::enter", function()
    show_battery_status()
  end)

  battery:connect_signal("mouse::leave", function()
    naughty.destroy(notification)
  end)

  return battery
end

return setmetatable({}, {
  __call = function(_, _)
    return _M.get()
  end,
})
