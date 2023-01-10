-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

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

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- {{{ Custom configs
-- UI
beautiful.useless_gap = dpi(5)
beautiful.font = "JetBrainsMono Nerd Font Bold 9"

-- Theme
beautiful.wallpaper = "/home/yashraj/Pictures/wall.png"

-- Background
beautiful.bg_normal = "#282828"
beautiful.bg_focus = "#32302f"
beautiful.bg_urgent = "#cc241d"
beautiful.bg_minimize = "#282828"

-- Foreground
beautiful.fg_normal = "#ebdbb2"
beautiful.fg_focus = "#fabd2f"
beautiful.fg_urgent = "#fb4934"
beautiful.fg_minimize = "#a89984"

-- Borders
beautiful.border_width = dpi(3)
beautiful.border_normal = "#282828"
beautiful.border_focus = "#d65d0e"
beautiful.border_color_normal = "#fe8019"

-- Taglist
beautiful.taglist_bg_focus = "#fe8019"
beautiful.taglist_fg_focus = "#1d2021"
-- beautiful.taglist_bg_occupied = "#282828"
-- beautiful.taglist_fg_occupied = "#282828"

-- Tasklist
beautiful.tasklist_bg_focus = "#282828"
beautiful.tasklist_fg_focus = "#98971a"
beautiful.tasklist_bg_normal = "#282828"
beautiful.tasklist_fg_normal = "#ebdbb2"
beautiful.tasklist_disable_icon = true
beautiful.tasklist_spacing = 5
beautiful.tasklist_forced_width = 5

-- Menu
beautiful.menu_height = dpi(20)
beautiful.menu_width = dpi(180)

-- Wibar
beautiful.wibar_height = dpi(25)

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
beautiful.bg_systray = "#282828"
beautiful.systray_icon_spacing = dpi(5)

-- Other
beautiful.snap_bg = "#d65d0e"

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
-- local neticon = wibox.widget.textbox();
-- neticon:set_markup(markup.fontbg("JetBrainsMono Nerd Font Bold 13", "#fe8019", "  "))
-- local net = lain.widget.net({
--   settings = function()
--     widget:set_markup(markup.fontfg("JetBrainsMono Nerd Font Bold 10", "#282828", string.format("%#7.1f", net_now.sent) .. " ﰵ " .. string.format("%#7.1f", net_now.received) .. " ﰬ "))
--   end
-- })
-- local netWibox = wiboxBox1(neticon, net.widget, "#ffffff", "#282828", 0, 0, 10)


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

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
{ "open terminal", terminal }
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.floating,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    })
end)
-- }}}

-- {{{ Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    -- awful.wallpaper {
    --     screen = s,
    --     widget = {
    --         {
    --             image     = beautiful.wallpaper,
    --             upscale   = true,
    --             downscale = true,
    --             widget    = wibox.widget.imagebox,
    --         },
    --         valign = "center",
    --         halign = "center",
    --         tiled  = false,
    --         widget = wibox.container.tile,
    --     }
    -- }

    awful.wallpaper {
        screen = s,
        widget = {
            horizontal_fit_policy = "fit",
            vertical_fit_policy   = "fit",
            image                 = beautiful.wallpaper,
            widget                = wibox.widget.imagebox,
        }
    }

end)
-- }}}

-- {{{ Wibar

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
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
-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
    {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    {description = "show main menu", group = "awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
    {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "x",
    function ()
        awful.prompt.run {
            prompt       = "Run Lua code: ",
            textbox      = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end,
    {description = "lua execute prompt", group = "awesome"}),
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
    {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    {description = "run prompt", group = "launcher"}),
    awful.key({ modkey }, "p", function() menubar.show() end,
    {description = "show the menubar", group = "launcher"}),

    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -D pipewire sset Master 4%+", false) end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -D pipewire sset Master 4%-", false) end),
    awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer -D pipewire sset Master toggle", false) end),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
              awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
            })

            -- Focus related keybindings
            awful.keyboard.append_global_keybindings({
                awful.key({ modkey,           }, "j",
                function ()
                    awful.client.focus.byidx( 1)
                end,
                {description = "focus next by index", group = "client"}
            ),
            awful.key({ modkey,           }, "k",
            function ()
                awful.client.focus.byidx(-1)
            end,
            {description = "focus previous by index", group = "client"}
        ),
        awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
        awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),
        awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}),
        awful.key({ modkey, "Control" }, "n",
        function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                end
            end,
            {description = "restore minimized", group = "client"}),
        })

        -- Layout related keybindings
        awful.keyboard.append_global_keybindings({
            awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
            {description = "swap with next client by index", group = "client"}),
            awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
            {description = "swap with previous client by index", group = "client"}),
            awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
            {description = "jump to urgent client", group = "client"}),
            awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
            {description = "increase master width factor", group = "layout"}),
            awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
            {description = "decrease master width factor", group = "layout"}),
            awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
            {description = "increase the number of master clients", group = "layout"}),
            awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
            {description = "decrease the number of master clients", group = "layout"}),
            awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
            {description = "increase the number of columns", group = "layout"}),
            awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
            {description = "decrease the number of columns", group = "layout"}),
            awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
            {description = "select next", group = "layout"}),
            awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
            {description = "select previous", group = "layout"}),
        })


        awful.keyboard.append_global_keybindings({
            awful.key {
                modifiers   = { modkey },
                keygroup    = "numrow",
                description = "only view tag",
                group       = "tag",
                on_press    = function (index)
                    local screen = awful.screen.focused()
                    local tag = screen.tags[index]
                    if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey,          }, "q",      function (c) c:kill()                         end,
        {description = "close", group = "client"}),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
        {description = "toggle floating", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
        {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
        {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
            {description = "(un)maximize vertically", group = "client"}),
        awful.key({ modkey, "Shift"   }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end ,
            {description = "(un)maximize horizontally", group = "client"}),
        })
    end)
    -- }}}

    -- {{{ Rules
    -- Rules to apply to new clients.
    ruled.client.connect_signal("request::rules", function()
        -- All clients will match this rule.
        ruled.client.append_rule {
            id         = "global",
            rule       = { },
            properties = {
                focus     = awful.client.focus.filter,
                raise     = true,
                screen    = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            }
        }

        -- Floating clients.
        ruled.client.append_rule {
            id       = "floating",
            rule_any = {
                instance = { "copyq", "pinentry" },
                class    = {
                    "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                    "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
                },
                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name    = {
                    "Event Tester",  -- xev.
                },
                role    = {
                    "AlarmWindow",    -- Thunderbird's calendar.
                    "ConfigManager",  -- Thunderbird's about:config.
                    "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = { floating = true }
        }

        -- Add titlebars to normal clients and dialogs
        -- ruled.client.append_rule {
            --     id         = "titlebars",
            --     rule_any   = { type = { "normal", "dialog" } },
            --     properties = { titlebars_enabled = true      }
            -- }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)
-- }}}

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    awful.titlebar(c).widget = {
        { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
    { -- Title
    halign = "center",
    widget = awful.titlebar.widget.titlewidget(c)
},
buttons = buttons,
layout  = wibox.layout.flex.horizontal
},
{ -- Right
awful.titlebar.widget.floatingbutton (c),
awful.titlebar.widget.maximizedbutton(c),
awful.titlebar.widget.stickybutton   (c),
awful.titlebar.widget.ontopbutton    (c),
awful.titlebar.widget.closebutton    (c),
layout = wibox.layout.fixed.horizontal()
},
layout = wibox.layout.align.horizontal
}
end)
-- }}}

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)
-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Autostart applications
-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "volumeicon", "picom" }) -- comma-separated entries