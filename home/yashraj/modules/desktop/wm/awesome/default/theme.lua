-- ░▀█▀░█░█░█▀▀░█▄█░█▀▀
-- ░░█░░█▀█░█▀▀░█░█░█▀▀
-- ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
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

-- ░█▀▀░█▀█░█░░░█▀█░█▀▄░█▀▀
-- ░█░░░█░█░█░░░█░█░█▀▄░▀▀█
-- ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

theme.background = xrdb.background or "#"
theme.foreground = xrdb.foreground or "#"
theme.color0 = xrdb.color0 or "#"
theme.color1 = xrdb.color1 or "#"
theme.color2 = xrdb.color2 or "#"
theme.color3 = xrdb.color3 or "#"
theme.color4 = xrdb.color4 or "#"
theme.color5 = xrdb.color5 or "#"
theme.color6 = xrdb.color6 or "#"
theme.color7 = xrdb.color7 or "#"
theme.color8 = xrdb.color8 or "#"
theme.color9 = xrdb.color9 or "#"
theme.color10 = xrdb.color10 or "#"
theme.color11 = xrdb.color11 or "#"
theme.color12 = xrdb.color12 or "#"
theme.color13 = xrdb.color13 or "#"
theme.color14 = xrdb.color14 or "#"
theme.color15 = xrdb.color15 or "#"

theme.darker_bg = "#1d2021"
theme.lighter_bg = "#3c3836"
theme.orange = "#d65d0e"
theme.dark = "#1d2021"
theme.light = "#3c3836"
theme.transparent = "#00000000"

-- Background Colors
theme.bg_dark = theme.color0
theme.bg_normal = theme.background
theme.bg_focus = theme.color0
theme.bg_urgent = theme.color8
theme.bg_minimize = theme.color8

-- Foreground Colors
theme.fg_normal = theme.color7
theme.fg_focus = theme.color5
theme.fg_urgent = theme.color3
theme.fg_minimize = theme.color8

--- ░█░█░▀█▀░░░█▀▀░█░░░█▀▀░█▄█░█▀▀░█▀█░▀█▀░█▀▀
--- ░█░█░░█░░░░█▀▀░█░░░█▀▀░█░█░█▀▀░█░█░░█░░▀▀█
--- ░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░░▀▀▀

-- Borders
-- ===================================================================
theme.border_width = dpi(3)
theme.border_normal = theme.lighter_bg
theme.border_focus = theme.color2
theme.border_radius = dpi(0) --picom should be used for round corners
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.color8

-- Taglist
-- ===================================================================
local taglist_square_size = dpi(0)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.orange
theme.taglist_fg_focus = theme.dark
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = theme.lighter_bg
theme.taglist_bg_urgent = theme.color1 .. '55'
theme.taglist_fg_urgent = theme.color1
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, theme.fg_normal)

-- Tasklist
-- ===================================================================
theme.tasklist_font = theme.font
theme.tasklist_disable_icon = true
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.color0
theme.tasklist_fg_focus = theme.color2
theme.tasklist_bg_normal = theme.color0
theme.tasklist_fg_normal = theme.foreground
theme.tasklist_bg_minimize = theme.color0 .. 55
theme.tasklist_fg_minimize = theme.foreground .. 55
theme.tasklist_disable_task_name = false
theme.tasklist_bg_urgent = theme.color0
theme.tasklist_fg_urgent = theme.color1
theme.tasklist_align = "center"

--- Titlebar
-- ===================================================================
theme.titlebar_enabled = false

-- Menu
-- Variables set for theming the menu:
-- ===================================================================
theme.menu_height = dpi(30)
theme.menu_width = dpi(150)
theme.menu_bg_normal = theme.background
theme.menu_fg_normal = theme.color7
theme.menu_bg_focus = theme.color4 .. 70
theme.menu_fg_focus = theme.color7
-- theme.menu_font = theme.font
theme.menu_border_width = theme.border_width / 2
theme.menu_border_color = theme.color8
theme.menu_submenu = ">  "
theme.menu_submenu_icon = nil

-- Gaps
-- ===================================================================
theme.useless_gap = dpi(8)
theme.screen_margin = dpi(0)

-- Wibar
-- ===================================================================
theme.wibar_position = "top"
theme.wibar_height = dpi(25)
theme.wibar_bg = theme.color0
-- theme.wibar_fg =
--theme.wibar_opacity = 0.7
-- theme.wibar_border_color =
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = dpi(0)
-- theme.wibar_width = dpi()

-- Systray
-- ===================================================================
theme.bg_systray = theme.color0

-- Notifications
-- Note: Some of these options are ignored by my custom notification widget
-- ===================================================================
theme.notification_position = "top_right"
theme.notification_border_width = dpi(0)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = theme.color8
theme.notification_bg = theme.background
theme.notification_fg = theme.foreground
theme.notification_crit_bg = theme.background
theme.notification_crit_fg = theme.color1
theme.notification_icon_size = dpi(60)
-- theme.notification_height = dpi(80)
-- theme.notification_width = dpi(300)
-- theme.notification_margin = dpi(16)
-- theme.notification_opacity = 1
-- theme.notification_font = theme.font
-- theme.notification_padding = theme.screen_margin * 2
-- theme.notification_spacing = theme.screen_margin * 2

-- Misc
-- ===================================================================
-- Recolor Layout icons
-- theme = theme_assets.recolor_layout(theme, theme.foreground)

-- Edge snap
-- theme.snap_shape = gears.shape.rectangle
theme.snap_bg = theme.lighter_bg
theme.snap_border_width = theme.border_width

return theme
-- EOF ------------------------------------------------------------------------
