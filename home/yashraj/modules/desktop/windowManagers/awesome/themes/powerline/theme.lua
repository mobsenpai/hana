-- ░▀█▀░█░█░█▀▀░█▄█░█▀▀
-- ░░█░░█▀█░█▀▀░█░█░█▀▀
-- ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

-- Inherit default theme
local theme = dofile(themes_path .. "default/theme.lua")
theme.wallpaper = "/home/yashraj/Pictures/wall.png"

-- ░█▀▀░█▀█░█▀█░▀█▀░█▀▀
-- ░█▀▀░█░█░█░█░░█░░▀▀█
-- ░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀

theme.font_name = "JetBrainsMono Nerd Font "
theme.font = theme.font_name .. "Bold 9"
theme.icon_font = theme.font_name .. "Bold "
theme.font_taglist = theme.font_name .. "Bold 8"

-- ░█▀▀░█▀█░█░░░█▀█░█▀▄░█▀▀
-- ░█░░░█░█░█░░░█░█░█▀▄░▀▀█
-- ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

theme.darker_bg = "#1d2021"
theme.lighter_bg = "#3c3836"
theme.orange = "#d65d0e"
theme.dark = "#1d2021"
theme.light = "#3c3836"
theme.xbackground = xrdb.background or "#131a21"
theme.xforeground = xrdb.foreground or "#ffffff"
theme.xcolor0 = xrdb.color0 or "#29343d"
theme.xcolor1 = xrdb.color1 or "#f9929b"
theme.xcolor2 = xrdb.color2 or "#7ed491"
theme.xcolor3 = xrdb.color3 or "#fbdf90"
theme.xcolor4 = xrdb.color4 or "#a3b8ef"
theme.xcolor5 = xrdb.color5 or "#ccaced"
theme.xcolor6 = xrdb.color6 or "#9ce5c0"
theme.xcolor7 = xrdb.color7 or "#ffffff"
theme.xcolor8 = xrdb.color8 or "#3b4b58"
theme.xcolor9 = xrdb.color9 or "#fca2aa"
theme.xcolor10 = xrdb.color10 or "#a5d4af"
theme.xcolor11 = xrdb.color11 or "#fbeab9"
theme.xcolor12 = xrdb.color12 or "#bac8ef"
theme.xcolor13 = xrdb.color13 or "#d7c1ed"
theme.xcolor14 = xrdb.color14 or "#c7e5d6"
theme.xcolor15 = xrdb.color15 or "#eaeaea"

-- Background Colors
theme.bg_dark = theme.xcolor0
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xcolor0
theme.bg_urgent = theme.xcolor8
theme.bg_minimize = theme.xcolor8

-- Foreground Colors
theme.fg_normal = theme.xcolor7
theme.fg_focus = theme.xcolor5
theme.fg_urgent = theme.xcolor3
theme.fg_minimize = theme.xcolor8

--- ░█░█░▀█▀░░░█▀▀░█░░░█▀▀░█▄█░█▀▀░█▀█░▀█▀░█▀▀
--- ░█░█░░█░░░░█▀▀░█░░░█▀▀░█░█░█▀▀░█░█░░█░░▀▀█
--- ░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░░▀▀▀

-- Borders
theme.border_width = dpi(3)
theme.oof_border_width = dpi(0)
theme.border_normal = theme.xcolor0
theme.border_focus = theme.xcolor2
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.xcolor0

-- Taglist
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
                                taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
                                  taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.orange
theme.taglist_fg_focus = theme.dark
theme.taglist_bg_urgent = theme.xcolor1 .. '55'
theme.taglist_fg_urgent = theme.xcolor1
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = theme.lighter_bg
theme.taglist_bg_volatile = transparent
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true

-- Tasklist
theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.darker_bg
theme.tasklist_fg_focus = theme.xcolor2
theme.tasklist_bg_minimize = theme.xcolor0 .. 55
theme.tasklist_fg_minimize = theme.xforeground .. 55
theme.tasklist_bg_normal = theme.xcolor0
theme.tasklist_fg_normal = theme.xforeground
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true
theme.tasklist_bg_urgent = theme.xcolor0
theme.tasklist_fg_urgent = theme.xcolor1
theme.tasklist_align = "center"

--- Titlebars
theme.titlebar_enabled = false

-- Menu
theme.menu_font = theme.font
theme.menu_bg_focus = theme.xcolor4 .. 70
theme.menu_fg_focus = theme.xcolor5
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal = theme.xcolor7
-- theme.menu_submenu_icon = gears.filesystem.get_configuration_dir() ..  "theme/icons/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width = dpi(130)
theme.menu_border_color = theme.xcolor8
theme.menu_border_width = theme.border_width / 2

-- Gaps
theme.useless_gap = dpi(8)

-- Wibar
theme.wibar_height = dpi(25)
theme.wibar_margin = dpi(15)
theme.wibar_spacing = dpi(15)
theme.wibar_bg = theme.xcolor0
theme.wibar_bg_secondary = theme.xbackground
theme.wibar_position = "top"

-- Systray
theme.systray_icon_spacing = dpi(10)
theme.bg_systray = theme.xcolor0
theme.systray_icon_size = dpi(20)
theme.systray_max_rows = 1

-- Recolor Layout icons
theme = theme_assets.recolor_layout(theme, theme.xforeground)

-- Menu
theme.menu_font = theme.font
theme.menu_bg_focus = theme.xcolor4 .. 70
theme.menu_fg_focus = theme.xcolor7
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal = theme.xcolor7
-- theme.menu_submenu_icon = gears.filesystem.get_configuration_dir() .. "theme/icons/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width = dpi(130)
theme.menu_border_color = theme.xcolor8
theme.menu_border_width = theme.border_width / 2

-- Notification
theme.notification_spacing = 19
theme.notification_border_width = dpi(0)
-- theme.notification_icon_size = 70

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- EOF ------------------------------------------------------------------------