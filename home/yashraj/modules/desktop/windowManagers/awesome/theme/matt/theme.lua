--  _   _
-- | |_| |__   ___ _ __ ___   ___
-- | __| '_ \ / _ \ '_ ` _ \ / _ \
-- | |_| | | |  __/ | | | | |  __/
--  \__|_| |_|\___|_| |_| |_|\___|

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local lain = require("lain")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local dpi = require("beautiful.xresources").apply_dpi

local themes_path = gears.filesystem.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")
-- {{{ Custom configs
-- UI
theme.useless_gap = dpi(5)
theme.font = "JetBrainsMono Nerd Font Bold 9"

-- Theme
theme.wallpaper = "/home/yashraj/Pictures/wall.png"

-- Background
theme.bg_normal = "#282828"
theme.bg_focus = "#32302f"
theme.bg_urgent = "#cc241d"
theme.bg_minimize = "#282828"

-- Foreground
theme.fg_normal = "#ebdbb2"
theme.fg_focus = "#fabd2f"
theme.fg_urgent = "#fb4934"
theme.fg_minimize = "#a89984"

-- Borders
theme.border_width = dpi(3)
theme.border_normal = "#282828"
theme.border_focus = "#d65d0e"
theme.border_color_normal = "#fe8019"

-- Taglist
theme.taglist_bg_focus = "#fe8019"
theme.taglist_fg_focus = "#1d2021"
-- theme.taglist_bg_occupied = "#282828"
-- theme.taglist_fg_occupied = "#282828"

-- Tasklist
theme.tasklist_bg_focus = "#282828"
theme.tasklist_fg_focus = "#98971a"
theme.tasklist_bg_normal = "#282828"
theme.tasklist_fg_normal = "#ebdbb2"
theme.tasklist_disable_icon = true
theme.tasklist_spacing = 5
theme.tasklist_forced_width = 5

-- Menu
theme.menu_height = dpi(20)
theme.menu_width = dpi(180)

-- Wibar
theme.wibar_height = dpi(25)

local markup = lain.util.markup
local separator = wibox.widget.textbox()
separator:set_text(" ")

-- Systray
local systray = wibox.widget{
    forced_height = dpi(2),
    base_size = dpi(22),
    halign = "center",
    valign = "center",
    widget = wibox.widget.systray,
}
theme.bg_systray = "#282828"
theme.systray_icon_spacing = dpi(5)

-- Other
theme.snap_bg = "#d65d0e"

-- Credit
-- https://github.com/raven2cz/awesomewm-config/blob/master/themes/multicolor/theme.lua
-- Note
-- Volume, notification, music module(s) are also available.

-- {{{ Modules
function wiboxBoxIconUnderline(icon, wbox, bgcolor, fgcolor, leftIn, rightIn, wiboxMargin)
  return {
    {
      {
        wibox.container.margin(wibox.widget { icon, wbox, layout = wibox.layout.align.horizontal }, leftIn, rightIn),
        fg = fgcolor,
        bg = bgcolor,
        widget = wibox.container.background
      },
      layout = wibox.container.margin
    },
    left = wiboxMargin,
    right = wiboxMargin,
    bottom = dpi(3),
    top = dpi(3),
    layout = wibox.container.margin
  }
end

local wiboxBox1 = wiboxBoxIconUnderline

-- Clock
local clockicon = wibox.widget.textbox();
clockicon:set_markup(markup.fontbg("JetBrainsMono Nerd Font Bold 11", "#83a598", "  "))
local mytextclock = wibox.widget.textclock(markup.fontfg("JetBrainsMono Nerd Font Bold 10", "#ffffff", " %a %b %d - %I:%M %p "))
local clockWibox = wiboxBox1(clockicon, mytextclock, "#458588", "#282828", 0, 0, 5)


-- CPU
local cpuicon = wibox.widget.textbox();
cpuicon:set_markup(markup.fontbg("JetBrainsMono Nerd Font Bold 13", "#fabd2f", "  "))
local cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.fontfg("JetBrainsMono Nerd Font Bold 10", "#d79921", " " .. cpu_now.usage .. "% "))
  end
})
local cpuWibox = wiboxBox1(cpuicon, cpu.widget, "#3c3836", "#1d2021", 0, 0, 5)


-- Net
local neticon = wibox.widget.textbox();
neticon:set_markup(markup.fontbg("JetBrainsMono Nerd Font Bold 13", "#fe8019", "  "))
local net = lain.widget.net({
  settings = function()
    widget:set_markup(markup.fontfg("JetBrainsMono Nerd Font Bold 10", "#282828", string.format("%#7.1f", net_now.sent) .. " ﰵ " .. string.format("%#7.1f", net_now.received) .. " ﰬ "))
  end
})
local netWibox = wiboxBox1(neticon, net.widget, "#ffffff", "#282828", 0, 0, 10)


-- MEM
local memicon = wibox.widget.textbox();
memicon:set_markup(markup.fontbg("JetBrainsMono Nerd Font Bold 10", "#8ec07c", "  "))
local mem = lain.widget.mem({
  settings = function()
    widget:set_markup(markup.fontfg("JetBrainsMono Nerd Font Bold 10", "#282828", " " .. mem_now.used .. " MB "))
  end
})
local memWibox = wiboxBox1(memicon, mem.widget, "#689d6a", "#1d2021", 0, 0, 5)


-- Weather widget
local tempicon = wibox.widget.textbox();
tempicon:set_markup(markup.fontbg("JetBrainsMono Nerd Font Bold 12", "#b8bb26", "  "))
local myWeather = lain.widget.weather({
    APPID = "d1b3b6a81db867259446b0863d5f9108",
    city_id = 1260086,
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
		units = math.floor(weather_now["main"]["temp"])
		widget:set_markup(markup.fontfg("JetBrainsMono Nerd Font Bold 10", "#98971a", " " .. descr .. ", " .. units .. "°C "))
    end
})
local weatherWibox = wiboxBox1(tempicon, myWeather, "#3c3836", "#282828", 0, 0, 5)

-- Keyboard map indicator and switcher
local keyboardText = wibox.widget{
    font = "JetBrainsMono Nerd Font Bold 11",
    markup = "<span background='#d3869b' foreground='#32302f'>   </span>",
    widget = wibox.widget.textbox
}
beautiful.mykeyboardlayout = awful.widget.keyboardlayout()
local keyboardWibox = wiboxBox1(keyboardText, beautiful.mykeyboardlayout, "#b16286", "#1d2021", 0, 0, 5)

  -- }}}
-- }}}