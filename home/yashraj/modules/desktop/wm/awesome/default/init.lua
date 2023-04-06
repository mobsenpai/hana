-- ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
-- ░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█
-- ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local dpi = require("beautiful.xresources").apply_dpi
-- Weather
local filesystem = gears.filesystem
local json = require("module.json")

-- ░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█
-- ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

-- Autostart
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

-- ░█░█░▀█▀
-- ░█░█░░█░
-- ░▀▀▀░▀▀▀

-- Default applications
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "firefox"
filemanager = "pcmanfm"
visual_editor = "code"

-- Default modkey.
modkey = "Mod4"

-- Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal(
    "request::default_layouts",
    function()
        awful.layout.append_default_layouts(
            {
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
                awful.layout.suit.max.fullscreen
                -- awful.layout.suit.magnifier,
                -- awful.layout.suit.corner.nw,
            }
        )
    end
)

-- {{ Menu
local menu = {}

menu.awesome = {
    {"Edit Config", editor_cmd .. " " .. awesome.conffile},
    {"Edit Config (GUI)", visual_editor .. " " .. awesome.conffile},
    {"Restart", awesome.restart},
    {
        "Close Session",
        function()
            awesome.quit()
        end
    }
}

menu.mainmenu =
    awful.menu {
    items = {
        {"  Terminal", terminal},
        {"  Explorer", filemanager},
        {"  Browser", browser},
        {"  Editor", editor_cmd},
        {"󰨞  GUI Editor", visual_editor},
        {"  AwesomeWM", menu.awesome}
    }
}

mylauncher =
    awful.widget.launcher(
    {
        image = beautiful.awesome_icon,
        menu = menu.mainmenu
    }
)
-- }}

-- ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀░█▀▀
-- ░█▄█░░█░░█░█░█░█░█▀▀░░█░░▀▀█
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░░▀▀▀

-- Systray
local mysystray = wibox.widget.systray()
mysystray.base_size = beautiful.systray_icon_size

--{{ Memory widget
memory_widget = wibox.widget({
    {
        {
            {
                id = "icon",
                text = "  ",
                font = beautiful.icon_font .. "10",
                widget = wibox.widget.textbox,
            },
            bg = beautiful.xcolor14,
            fg = beautiful.darker_bg,
            widget = wibox.widget.background,
        },
        {
            id = "text",
            text = "",
            font = beautiful.icon_font .. "10",
            widget = wibox.widget.textbox,
        },
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal,
    },
    fg = beautiful.darker_bg,
    bg = beautiful.xcolor6,
    widget = wibox.container.background,
})

local update_interval = 20
local ram_script = [[
  sh -c "
  free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'
  "]]

-- Periodically get ram info
awful.widget.watch(ram_script, update_interval, function(widget, stdout)
    local available = stdout:match('(.*)@@')
    local total = stdout:match('@@(.*)@')
    local used = tonumber(total) - tonumber(available)
    -- weather_widget attach
    local usage = memory_widget:get_children_by_id("text")[1]
    memory_widget:emit_signal("widget::redraw_needed")
    usage:set_text(used .. " MB ")
end)

--{{ Clock widget
    clock_widget = wibox.widget({
        {
            {
                {
                    id = "icon",
                    text = "  ",
                    font = beautiful.icon_font .. "10",
                    widget = wibox.widget.textbox,
                },
                bg = beautiful.xcolor12,
                fg = beautiful.darker_bg,
                widget = wibox.widget.background,
            },
            {
                id = "text",
                format = "%a %b %d - %I:%M %p ",
                font = beautiful.icon_font .. "10",
                widget = wibox.widget.textclock,
            },
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal,
        },
        fg = "#ffffff",
        bg = beautiful.xcolor4,
        widget = wibox.container.background,
    })
-- }}

--{{ CPU widget
cpu_widget = wibox.widget({
    {
        {
            {
                id = "icon",
                text = "  ",
                font = beautiful.icon_font .. "12",
                widget = wibox.widget.textbox,
            },
            bg = beautiful.xcolor11,
            fg = beautiful.darker_bg,
            widget = wibox.widget.background,
        },
        {
            id = "text",
            text = "",
            font = beautiful.icon_font .. "10",
            widget = wibox.widget.textbox,
        },
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal,
    },
    fg = beautiful.xcolor3,
    bg = beautiful.lighter_bg,
    widget = wibox.container.background,
})

local update_interval = 5
local cpu_idle_script = [[
  sh -c "
  vmstat 1 2 | tail -1 | awk '{printf \"%d\", $15}'
  "]]

-- Periodically get cpu info
awful.widget.watch(cpu_idle_script, update_interval, function(widget, stdout)
    local cpu_idle = stdout
    cpu_idle = string.gsub(cpu_idle, '^%s*(.-)%s*$', '%1')
    local used = 100 - tonumber(cpu_idle)
    -- cpu_widget attach
    local usage = cpu_widget:get_children_by_id("text")[1]
    cpu_widget:emit_signal("widget::redraw_needed")
    usage:set_text(used .. "% ")
end)
-- }}

-- {{ Weather widget
local GET_FORECAST_CMD = [[bash -c "curl -s --show-error -X GET '%s'"]]

local current_weather_widget = wibox.widget({
    {
        {
            {
                id = "icon",
                text = "  ",
                font = beautiful.icon_font .. "10",
                widget = wibox.widget.textbox,
            },
            bg = beautiful.xcolor10,
            fg = beautiful.darker_bg,
            widget = wibox.widget.background,
        },
        {
            id = "description",
            text = "Mostly cloudy,",
            font = beautiful.icon_font .. "10",
            widget = wibox.widget.textbox,
        },
        nil,
        {
            id = "tempareture_current",
            markup = "20<sup><span>°</span></sup><span>C </span>",
            align = "right",
            font = beautiful.icon_font .. "10",
            widget = wibox.widget.textbox,
        },
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal,
    },
    fg = beautiful.xcolor2,
    bg = beautiful.lighter_bg,
    widget = wibox.container.background
})

local api_key = "d1b3b6a81db867259446b0863d5f9108"
local coordinates = {
    "25.6", --- lat
    "85.1167", --- lon
}
local units = "metric"

local url = (
	"https://api.openweathermap.org/data/2.5/onecall"
	.. "?lat="
	.. coordinates[1]
	.. "&lon="
	.. coordinates[2]
	.. "&appid="
	.. api_key
	.. "&units="
	.. units
	.. "&exclude=minutely"
)

awful.widget.watch(string.format(GET_FORECAST_CMD, url), 600, function(_, stdout, stderr)
	if stderr == "" then
		local result = json.decode(stdout)
		-- Current weather setup
		local description = current_weather_widget:get_children_by_id("description")[1]
		local temp_current = current_weather_widget:get_children_by_id("tempareture_current")[1]
        current_weather_widget:emit_signal("widget::redraw_needed")
		description:set_text(result.current.weather[1].description:gsub("^%l", string.upper) .. ",")
		temp_current:set_markup(math.floor(result.current.temp) .. "<sup><span>°</span></sup><span>C </span>")
	end
end)
-- }}

-- {{Volume osd
-- Provides:
-- signal::volume
--      percentage (integer)
--      muted (boolean)
-- needs pamixer installed

local volume_old = -1
local muted_old = -1
local function emit_volume_info()
    -- Get volume info of the currently active sink
    awful.spawn.easy_async_with_shell(
        'echo -n $(pamixer --get-mute); echo "_$(pamixer --get-volume)"',
        function(stdout)

            local bool = string.match(stdout, "(.-)_")
            local volume = string.match(stdout, "%d+")
            local muted_int = -1
            if bool == "true" then muted_int = 1 else muted_int = 0 end
            local volume_int = tonumber(volume)

            -- Only send signal if there was a change
            -- We need this since we use `pactl subscribe` to detect
            -- volume events. These are not only triggered when the
            -- user adjusts the volume through a keybind, but also
            -- through `pavucontrol` or even without user intervention,
            -- when a media file starts playing.
            if volume_int ~= volume_old or muted_int ~= muted_old then
                awesome.emit_signal("signal::volume", volume_int, muted_int)
                volume_old = volume_int
                muted_old = muted_int
            end
        end)
end

-- Run once to initialize widgets
emit_volume_info()

-- Sleeps until pactl detects an event (volume up/down/toggle mute)
local volume_script = [[
    bash -c "
    LANG=C pactl subscribe 2> /dev/null | grep --line-buffered \"Event 'change' on sink #\"
    "]]

-- Kill old pactl subscribe processes
awful.spawn.easy_async({
    "pkill", "--full", "--uid", os.getenv("USER"), "^pactl subscribe"
}, function()
    -- Run emit_volume_info() with each line printed
    awful.spawn.with_line_callback(volume_script, {
        stdout = function(line) emit_volume_info() end
    })
end)

local width = dpi(50)
local height = dpi(300)

local volume_icon = wibox.widget {
    markup = "<span foreground='" .. beautiful.xcolor4 .. "'><b></b></span>",
    align = 'center',
    valign = 'center',
    font = beautiful.font_name .. '20',
    widget = wibox.widget.textbox
}

local volume_adjust = awful.popup({
    type = "notification",
    maximum_width = width,
    maximum_height = height,
    visible = false,
    ontop = true,
    widget = wibox.container.background,
    bg = "#00000000",
    placement = function(c)
        awful.placement.right(c, {margins = {right = 10}})
    end
})

local volume_bar = wibox.widget {
    bar_shape = gears.shape.rounded_rect,
    shape = gears.shape.rounded_rect,
    background_color = beautiful.lighter_bg,
    color = beautiful.xcolor4,
    max_value = 100,
    value = 0,
    widget = wibox.widget.progressbar
}

local volume_ratio = wibox.widget {
    layout = wibox.layout.ratio.vertical,
    {
        {volume_bar, direction = "east", widget = wibox.container.rotate},
        top = dpi(20),
        left = dpi(20),
        right = dpi(20),
        widget = wibox.container.margin
    },
    volume_icon,
    nil
}

volume_ratio:adjust_ratio(2, 0.72, 0.28, 0)

local rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

volume_adjust.widget = wibox.widget {
    volume_ratio,
    shape = rrect(beautiful.border_radius / 2),
    border_width = beautiful.widget_border_width,
    border_color = beautiful.widget_border_color,
    bg = beautiful.xbackground,
    widget = wibox.container.background
}

-- create a 3 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_volume_adjust = gears.timer {
    timeout = 3,
    autostart = true,
    callback = function()
        volume_adjust.visible = false
        volume_bar.mouse_enter = false
    end
}

awesome.connect_signal("signal::volume", function(vol, muted)
    volume_bar.value = vol

    if muted == 1 or vol == 0 then
        volume_icon.markup = "<span foreground='" .. beautiful.xcolor4 ..
                                 "'><b>ﳌ</b></span>"
    else
        volume_icon.markup = "<span foreground='" .. beautiful.xcolor4 ..
                                 "'><b></b></span>"
    end

    if volume_adjust.visible then
        hide_volume_adjust:again()
    else
        volume_adjust.visible = true
        hide_volume_adjust:start()
    end

end)
-- }}

-- {{
-- Hover function
function add_hover_cursor(w, hover_cursor)
    local original_cursor = "left_ptr"

    w:connect_signal("mouse::enter", function()
        local w = _G.mouse.current_wibox
        if w then w.cursor = hover_cursor end
    end)

    w:connect_signal("mouse::leave", function()
        local w = _G.mouse.current_wibox
        if w then w.cursor = original_cursor end
    end)
end

-- Usage
-- add_hover_cursor(cpu_widget, "hand2")
-- }}

-- ░█░█░█▀█░█░░░█░░░█▀█░█▀█░█▀█░█▀▀░█▀▄
-- ░█▄█░█▀█░█░░░█░░░█▀▀░█▀█░█▀▀░█▀▀░█▀▄
-- ░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░░░▀░▀░▀░░░▀▀▀░▀░▀
-- Single wallpaper
awful.screen.connect_for_each_screen(
    function(s)
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper

            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end

            gears.wallpaper.maximized(wallpaper, s, false, nil)
        end
    end
)

-- ░█░█░▀█▀░█▀▄░█▀█░█▀▄
-- ░█▄█░░█░░█▀▄░█▀█░█▀▄
-- ░▀░▀░▀▀▀░▀▀░░▀░▀░▀░▀
screen.connect_signal(
    "request::desktop_decoration",
    function(s)
        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()

        -- Create layoutbox widget
        s.mylayoutbox =
            awful.widget.layoutbox {
            screen = s,
            buttons = {
                awful.button(
                    {},
                    1,
                    function()
                        awful.layout.inc(1)
                    end
                ),
                awful.button(
                    {},
                    3,
                    function()
                        awful.layout.inc(-1)
                    end
                ),
                awful.button(
                    {},
                    4,
                    function()
                        awful.layout.inc(-1)
                    end
                ),
                awful.button(
                    {},
                    5,
                    function()
                        awful.layout.inc(1)
                    end
                )
            }
        }

        -- Create a taglist widget
        s.mytaglist =
            awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = {
                awful.button(
                    {},
                    1,
                    function(t)
                        t:view_only()
                    end
                ),
                awful.button(
                    {modkey},
                    1,
                    function(t)
                        if client.focus then
                            client.focus:move_to_tag(t)
                        end
                    end
                ),
                awful.button({}, 3, awful.tag.viewtoggle),
                awful.button(
                    {modkey},
                    3,
                    function(t)
                        if client.focus then
                            client.focus:toggle_tag(t)
                        end
                    end
                ),
                awful.button(
                    {},
                    4,
                    function(t)
                        awful.tag.viewprev(t.screen)
                    end
                ),
                awful.button(
                    {},
                    5,
                    function(t)
                        awful.tag.viewnext(t.screen)
                    end
                )
            }
        }

        -- Create a tasklist widget
        s.mytasklist =
            awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = {
                awful.button(
                    {},
                    1,
                    function(c)
                        c:activate {context = "tasklist", action = "toggle_minimization"}
                    end
                ),
                awful.button(
                    {},
                    3,
                    function()
                        awful.menu.client_list {theme = {width = 250}}
                    end
                ),
                awful.button(
                    {},
                    4,
                    function()
                        awful.client.focus.byidx(-1)
                    end
                ),
                awful.button(
                    {},
                    5,
                    function()
                        awful.client.focus.byidx(1)
                    end
                )
            }
        }

        -- Create the wibox
        s.mywibox = awful.wibar({position = beautiful.wibar_position, screen = s})

        s.mywibox:setup {
            {
            layout = wibox.layout.align.horizontal,
            expand = "none",
                {
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal,
                    s.mytaglist,
                    s.mypromptbox,
                    s.mytasklist
                },
                {
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal,
                    current_weather_widget,
                },
                {
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal,
                    memory_widget,
                    cpu_widget,
                    clock_widget,
                    mysystray,
                }
            },
            top = dpi(3),
            bottom = dpi(3),
            left = dpi(3),
            right = dpi(3),
            layout = wibox.container.margin,
        }
    end
)

-- ░█░█░█▀▀░█░█░█▀▄░▀█▀░█▀█░█▀▄░█▀▀
-- ░█▀▄░█▀▀░░█░░█▀▄░░█░░█░█░█░█░▀▀█
-- ░▀░▀░▀▀▀░░▀░░▀▀░░▀▀▀░▀░▀░▀▀░░▀▀▀

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings(
    {
        awful.button(
            {},
            3,
            function()
                menu.mainmenu:toggle()
            end
        ),
        awful.button({}, 4, awful.tag.viewprev),
        awful.button({}, 5, awful.tag.viewnext)
    }
)
-- }}}

-- My Awesomewm keybinds
awful.keyboard.append_global_keybindings(
    {
        -- Screen Shots/Vids
        awful.key(
            {},
            "Print",
            function()
                awful.spawn("flameshot gui")
            end,
            {description = "flameshot gui", group = "awesome"}
        ),
        awful.key(
            {"Shift"},
            "Print",
            function()
                awful.spawn("flameshot gui -d 2000")
            end,
            {description = "flameshot gui with 2 second delay", group = "awesome"}
        ),
        --- App launcher
        awful.key(
            {modkey},
            "d",
            function()
                awful.spawn("rofi -no-lazy-grab -show drun -modi drun")
            end,
            {description = "open app launcher", group = "app"}
        ),
        --- Emoji picker
        awful.key(
            {modkey},
            "e",
            function()
                awful.spawn("rofi -no-lazy-grab -show emoji -modi emoji")
            end,
            {description = "open emoji picker", group = "app"}
        ),
        --- Clipboard
        awful.key(
            {modkey},
            "c",
            function()
                awful.spawn("clipmenu")
            end,
            {description = "open clipboard", group = "app"}
        )
    }
)

-- General Awesome keys
awful.keyboard.append_global_keybindings(
    {
        awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
        awful.key(
            {modkey},
            "w",
            function()
                menu.mainmenu:show()
            end,
            {description = "show main menu", group = "awesome"}
        ),
        awful.key({modkey, "Control"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
        awful.key({modkey, "Shift"}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
        awful.key(
            {modkey},
            "x",
            function()
                awful.prompt.run {
                    prompt = "Run Lua code: ",
                    textbox = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                }
            end,
            {description = "lua execute prompt", group = "awesome"}
        ),
        awful.key(
            {modkey},
            "Return",
            function()
                awful.spawn(terminal)
            end,
            {description = "open a terminal", group = "launcher"}
        ),
        awful.key(
            {modkey},
            "r",
            function()
                awful.screen.focused().mypromptbox:run()
            end,
            {description = "run prompt", group = "launcher"}
        ),
        awful.key(
            {modkey},
            "p",
            function()
                menubar.show()
            end,
            {description = "show the menubar", group = "launcher"}
        ),
        -- {{
            -- Volume control
            awful.key({}, "XF86AudioRaiseVolume",
            function() awful.spawn("pamixer -i 3") end,
            {description = "increase volume", group = "awesome"}),
            awful.key({}, "XF86AudioLowerVolume",
            function() awful.spawn("pamixer -d 3") end,
            {description = "decrease volume", group = "awesome"}),
            awful.key({}, "XF86AudioMute", function() awful.spawn("pamixer -t") end,
            {description = "mute volume", group = "awesome"}),
        -- }}
    }
)

-- Tags related keybindings
awful.keyboard.append_global_keybindings(
    {
        awful.key({modkey}, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
        awful.key({modkey}, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
        awful.key({modkey}, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"})
    }
)

-- Focus related keybindings
awful.keyboard.append_global_keybindings(
    {
        awful.key(
            {modkey},
            "j",
            function()
                awful.client.focus.byidx(1)
            end,
            {description = "focus next by index", group = "client"}
        ),
        awful.key(
            {modkey},
            "k",
            function()
                awful.client.focus.byidx(-1)
            end,
            {description = "focus previous by index", group = "client"}
        ),
        awful.key(
            {modkey},
            "Tab",
            function()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end,
            {description = "go back", group = "client"}
        ),
        awful.key(
            {modkey, "Control"},
            "j",
            function()
                awful.screen.focus_relative(1)
            end,
            {description = "focus the next screen", group = "screen"}
        ),
        awful.key(
            {modkey, "Control"},
            "k",
            function()
                awful.screen.focus_relative(-1)
            end,
            {description = "focus the previous screen", group = "screen"}
        ),
        awful.key(
            {modkey, "Control"},
            "n",
            function()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:activate {raise = true, context = "key.unminimize"}
                end
            end,
            {description = "restore minimized", group = "client"}
        )
    }
)

-- Layout related keybindings
awful.keyboard.append_global_keybindings(
    {
        awful.key(
            {modkey, "Shift"},
            "j",
            function()
                awful.client.swap.byidx(1)
            end,
            {description = "swap with next client by index", group = "client"}
        ),
        awful.key(
            {modkey, "Shift"},
            "k",
            function()
                awful.client.swap.byidx(-1)
            end,
            {description = "swap with previous client by index", group = "client"}
        ),
        awful.key({modkey}, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),
        awful.key(
            {modkey},
            "l",
            function()
                awful.tag.incmwfact(0.05)
            end,
            {description = "increase master width factor", group = "layout"}
        ),
        awful.key(
            {modkey},
            "h",
            function()
                awful.tag.incmwfact(-0.05)
            end,
            {description = "decrease master width factor", group = "layout"}
        ),
        awful.key(
            {modkey, "Shift"},
            "h",
            function()
                awful.tag.incnmaster(1, nil, true)
            end,
            {description = "increase the number of master clients", group = "layout"}
        ),
        awful.key(
            {modkey, "Shift"},
            "l",
            function()
                awful.tag.incnmaster(-1, nil, true)
            end,
            {description = "decrease the number of master clients", group = "layout"}
        ),
        awful.key(
            {modkey, "Control"},
            "h",
            function()
                awful.tag.incncol(1, nil, true)
            end,
            {description = "increase the number of columns", group = "layout"}
        ),
        awful.key(
            {modkey, "Control"},
            "l",
            function()
                awful.tag.incncol(-1, nil, true)
            end,
            {description = "decrease the number of columns", group = "layout"}
        ),
        awful.key(
            {modkey},
            "space",
            function()
                awful.layout.inc(1)
            end,
            {description = "select next", group = "layout"}
        ),
        awful.key(
            {modkey, "Shift"},
            "space",
            function()
                awful.layout.inc(-1)
            end,
            {description = "select previous", group = "layout"}
        )
    }
)

awful.keyboard.append_global_keybindings(
    {
        awful.key {
            modifiers = {modkey},
            keygroup = "numrow",
            description = "only view tag",
            group = "tag",
            on_press = function(index)
                local screen = awful.screen.focused()
                local tag = screen.tags[index]
                if tag then
                    tag:view_only()
                end
            end
        },
        awful.key {
            modifiers = {modkey, "Control"},
            keygroup = "numrow",
            description = "toggle tag",
            group = "tag",
            on_press = function(index)
                local screen = awful.screen.focused()
                local tag = screen.tags[index]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end
        },
        awful.key {
            modifiers = {modkey, "Shift"},
            keygroup = "numrow",
            description = "move focused client to tag",
            group = "tag",
            on_press = function(index)
                if client.focus then
                    local tag = client.focus.screen.tags[index]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end
        },
        awful.key {
            modifiers = {modkey, "Control", "Shift"},
            keygroup = "numrow",
            description = "toggle focused client on tag",
            group = "tag",
            on_press = function(index)
                if client.focus then
                    local tag = client.focus.screen.tags[index]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end
        },
        awful.key {
            modifiers = {modkey},
            keygroup = "numpad",
            description = "select layout directly",
            group = "layout",
            on_press = function(index)
                local t = awful.screen.focused().selected_tag
                if t then
                    t.layout = t.layouts[index] or t.layout
                end
            end
        }
    }
)

client.connect_signal(
    "request::default_mousebindings",
    function()
        awful.mouse.append_client_mousebindings(
            {
                awful.button(
                    {},
                    1,
                    function(c)
                        c:activate {context = "mouse_click"}
                    end
                ),
                awful.button(
                    {modkey},
                    1,
                    function(c)
                        c:activate {context = "mouse_click", action = "mouse_move"}
                    end
                ),
                awful.button(
                    {modkey},
                    3,
                    function(c)
                        c:activate {context = "mouse_click", action = "mouse_resize"}
                    end
                )
            }
        )
    end
)

client.connect_signal(
    "request::default_keybindings",
    function()
        awful.keyboard.append_client_keybindings(
            {
                awful.key(
                    {modkey},
                    "f",
                    function(c)
                        c.fullscreen = not c.fullscreen
                        c:raise()
                    end,
                    {description = "toggle fullscreen", group = "client"}
                ),
                awful.key(
                    {modkey},
                    "q",
                    function(c)
                        c:kill()
                    end,
                    {description = "close", group = "client"}
                ),
                awful.key(
                    {modkey, "Control"},
                    "space",
                    awful.client.floating.toggle,
                    {description = "toggle floating", group = "client"}
                ),
                awful.key(
                    {modkey, "Control"},
                    "Return",
                    function(c)
                        c:swap(awful.client.getmaster())
                    end,
                    {description = "move to master", group = "client"}
                ),
                awful.key(
                    {modkey},
                    "o",
                    function(c)
                        c:move_to_screen()
                    end,
                    {description = "move to screen", group = "client"}
                ),
                awful.key(
                    {modkey},
                    "t",
                    function(c)
                        c.ontop = not c.ontop
                    end,
                    {description = "toggle keep on top", group = "client"}
                ),
                awful.key(
                    {modkey},
                    "n",
                    function(c)
                        -- The client currently has the input focus, so it cannot be
                        -- minimized, since minimized clients can't have the focus.
                        c.minimized = true
                    end,
                    {description = "minimize", group = "client"}
                ),
                awful.key(
                    {modkey},
                    "m",
                    function(c)
                        c.maximized = not c.maximized
                        c:raise()
                    end,
                    {description = "(un)maximize", group = "client"}
                ),
                awful.key(
                    {modkey, "Control"},
                    "m",
                    function(c)
                        c.maximized_vertical = not c.maximized_vertical
                        c:raise()
                    end,
                    {description = "(un)maximize vertically", group = "client"}
                ),
                awful.key(
                    {modkey, "Shift"},
                    "m",
                    function(c)
                        c.maximized_horizontal = not c.maximized_horizontal
                        c:raise()
                    end,
                    {description = "(un)maximize horizontally", group = "client"}
                )
            }
        )
    end
)

-- ░█▀▄░█░█░█░░░█▀▀░█▀▀
-- ░█▀▄░█░█░█░░░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀

-- Rules to apply to new clients.
ruled.client.connect_signal(
    "request::rules",
    function()
        -- All clients will match this rule.
        ruled.client.append_rule {
            id = "global",
            rule = {},
            properties = {
                focus = awful.client.focus.filter,
                raise = true,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap + awful.placement.no_offscreen
            }
        }

        -- Floating clients.
        ruled.client.append_rule {
            id = "floating",
            rule_any = {
                instance = {"music", },
                class = {
                    "Arandr",
                    "Sxiv",
                    "Wpa_gui",

                },
                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Friends List",
                },
                role = {
                    "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = {floating = true, placement = awful.placement.centered}
        }
    end
)

-- ░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█
-- ░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        c:activate {context = "mouse_enter", raise = false}
    end
)

client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)

-- Autostart applications
run_once({"picom", "clipmenud", "xss-lock -- betterlockscreen -l"}) -- comma-separated entries

-- EOF ------------------------------------------------------------------------
