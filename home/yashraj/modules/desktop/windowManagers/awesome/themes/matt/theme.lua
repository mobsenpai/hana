--  _   _
-- | |_| |__   ___ _ __ ___   ___
-- | __| '_ \ / _ \ '_ ` _ \ / _ \
-- | |_| | | |  __/ | | | | |  __/
--  \__|_| |_|\___|_| |_| |_|\___|

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("theme.xresources").apply_dpi
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")


-- Global font
theme.font = "JetBrainsMono Nerd Font Bold 9"
theme.fontE = "JetBrainsMono Nerd Font"
theme.wallpaper = "/home/yashraj/Pictures/wall.png"
-- Black (background)
theme.base00 = "282828"
theme.base08 = "665c54"

-- Black variations (for status bars and stuff) (dark -> light)
theme.base01 = "3c3836"
theme.base02 = "504945"
theme.base03 = "665c54"
theme.base04 = "bdae93"
theme.base05 = "d5c4a1"
theme.base06 = "ebdbb2"

-- Bright colors
theme.base09 = "fb4934" -- red
theme.base0A = "b8bb26" -- green
theme.base0B = "fabd2f" -- yellow
theme.base0C = "83a598" -- blue
theme.base0D = "d3869b" -- magenta
theme.base0E = "8ec07c" -- cyan

-- White (foreground)
theme.base07 = "fbf1c7"
theme.base0F = "ebdbb2"

-- Dark colors (09 - 0E)
theme.base09D = "cc241d" -- red D
theme.base0AD = "98971a" -- green D
theme.base0BD = "d79921" -- yellow D
theme.base0CD = "458588" -- blue D
theme.base0DD = "b16286" -- magenta D
theme.base0ED = "689d6a" -- cyan D

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
    theme.base_size = dpi(22),
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
clockicon:set_markup(markup.fontbg(theme.fontE .. 11, "#83a598", "  "))
local mytextclock = wibox.widget.textclock(markup.fontfg(theme.fontE .. 10, "#ffffff", " %a %b %d - %I:%M %p "))
local clockWibox = wiboxBox1(clockicon, mytextclock, "#458588", "#282828", 0, 0, 5)


-- CPU
local cpuicon = wibox.widget.textbox();
cpuicon:set_markup(markup.fontbg(theme.fontE .. 13, "#fabd2f", "  "))
local cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.fontfg(theme.fontE .. 10, "#d79921", " " .. cpu_now.usage .. "% "))
  end
})
local cpuWibox = wiboxBox1(cpuicon, cpu.widget, "#3c3836", "#1d2021", 0, 0, 5)


-- Net
local neticon = wibox.widget.textbox();
neticon:set_markup(markup.fontbg(theme.fontE .. 13, "#fe8019", "  "))
local net = lain.widget.net({
  settings = function()
    widget:set_markup(markup.fontfg(theme.fontE .. 10, "#282828", string.format("%#7.1f", net_now.sent) .. " ﰵ " .. string.format("%#7.1f", net_now.received) .. " ﰬ "))
  end
})
local netWibox = wiboxBox1(neticon, net.widget, "#ffffff", "#282828", 0, 0, 10)


-- MEM
local memicon = wibox.widget.textbox();
memicon:set_markup(markup.fontbg(theme.fontE .. 10, "#8ec07c", "  "))
local mem = lain.widget.mem({
  settings = function()
    widget:set_markup(markup.fontfg(theme.fontE .. 10, "#282828", " " .. mem_now.used .. " MB "))
  end
})
local memWibox = wiboxBox1(memicon, mem.widget, "#689d6a", "#1d2021", 0, 0, 5)


-- Weather widget
local tempicon = wibox.widget.textbox();
tempicon:set_markup(markup.fontbg(theme.fontE .. 12, "#b8bb26", "  "))
local myWeather = lain.widget.weather({
    APPID = "d1b3b6a81db867259446b0863d5f9108",
    city_id = 1260086,
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
		units = math.floor(weather_now["main"]["temp"])
		widget:set_markup(markup.fontfg(theme.fontE .. 10, "#98971a", " " .. descr .. ", " .. units .. "°C "))
    end
})
local weatherWibox = wiboxBox1(tempicon, myWeather, "#3c3836", "#282828", 0, 0, 5)

-- Keyboard map indicator and switcher
local keyboardText = wibox.widget{
    font = theme.fontE .. 11,
    markup = "<span background='#d3869b' foreground='#32302f'>   </span>",
    widget = wibox.widget.textbox
}
theme.mykeyboardlayout = awful.widget.keyboardlayout()
local keyboardWibox = wiboxBox1(keyboardText, theme.mykeyboardlayout, "#b16286", "#1d2021", 0, 0, 5)

    -- }}}
screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        -- filter  = awful.widget.tasklist.filter.focused,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mylayoutbox,
            s.mytaglist,
            separator,
            s.mypromptbox,
        },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                separator,
                -- mykeyboardlayout,
                -- mytextclock,
                -- netWibox,
                keyboardWibox,
                weatherWibox,
                memWibox,
                cpuWibox,
                clockWibox,
                separator,
                systray,
                -- wibox.widget.systray(),
                -- s.mylayoutbox,
            }
        }
    }
end)