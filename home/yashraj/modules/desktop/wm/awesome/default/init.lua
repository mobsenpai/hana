-- ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
-- ░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█
-- ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- local lain = require("lain")
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
-- Theme specific
local separator = {
    left = dpi(10),
    widget = wibox.container.margin
}

-- ░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█
-- ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

-- Module
function markupBlocks(icon, wbox, bgcolor, fgcolor)
    return {
        {
            {
                wibox.container.margin(wibox.widget {icon, wbox, layout = wibox.layout.align.horizontal}),
                fg = fgcolor,
                bg = bgcolor,
                widget = wibox.container.background
            },
            layout = wibox.container.margin
        },
        left = dpi(10),
        bottom = dpi(3),
        top = dpi(3),
        layout = wibox.container.margin
    }
end

local makeWidget = markupBlocks

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

-- {{{ Menu
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
-- }}}

-- ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀░█▀▀
-- ░█▄█░░█░░█░█░█░█░█▀▀░░█░░▀▀█
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░░▀▀▀

-- Systray
local mysystray = wibox.widget.systray()
mysystray.base_size = beautiful.systray_icon_size

--{{ check after check bling weather
-- Provides:
-- signal::ram
--      used (integer - mega bytes)
--      total (integer - mega bytes)
-- local awful = require("awful")

local update_interval = 20
-- Returns the used amount of ram in percentage
-- TODO output of free is affected by system language. The following command
-- works for any language:
-- free -m | sed -n '2p' | awk '{printf "%d available out of %d\n", $7, $2}'
local ram_script = [[
  sh -c "
  free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'
  "]]

-- Periodically get ram info

memWidget = awful.widget.watch(ram_script, update_interval, function(widget, stdout)
    local available = stdout:match('(.*)@@')
    local total = stdout:match('@@(.*)@')
    local used = tonumber(total) - tonumber(available)
    -- awesome.emit_signal("signal::ram", used, total)
    widget:set_markup("<span font='" .. beautiful.icon_font .. "10'" .. "background='" .. beautiful.xcolor14 .. "'foreground='" .. beautiful.darker_bg .. "'>  " .."</span>" .. "<span font='" .. beautiful.icon_font .. "10'" .. "background='" .. beautiful.xcolor6 .. "'foreground='" .. beautiful.darker_bg .. "'> " .. used .." MB </span>")
end)


--}} note the font size also increases the bar height so make one font only, fontbold?

--{{ clock
clockWidget = awful.widget.textclock("<span font='" .. beautiful.icon_font .. "10'" .. "background='" .. beautiful.xcolor12 .. "'foreground='" .. beautiful.darker_bg .. "'>  " .."</span>" .. "<span font='" .. beautiful.icon_font .. "10'" .. "background='" .. beautiful.xcolor4 .. "'foreground='#ffffff'> %a %b %d - %I:%M %p </span>")

-- }}

--{{ cpu
-- Provides:
-- signal::cpu
--      used percentage (integer)
-- local awful = require("awful")

local update_interval = 5
local cpu_idle_script = [[
  sh -c "
  vmstat 1 2 | tail -1 | awk '{printf \"%d\", $15}'
  "]]

-- Periodically get cpu info
cpuWidget = awful.widget.watch(cpu_idle_script, update_interval, function(widget, stdout)
    -- local cpu_idle = stdout:match('+(.*)%.%d...(.*)%(')
    local cpu_idle = stdout
    cpu_idle = string.gsub(cpu_idle, '^%s*(.-)%s*$', '%1')
    local used = 100 - tonumber(cpu_idle)
    -- awesome.emit_signal("signal::cpu", 100 - tonumber(cpu_idle))
    widget:set_markup("<span font='" .. beautiful.icon_font .. "10'" .. "background='" .. beautiful.xcolor11 .. "'foreground='" .. beautiful.darker_bg .. "'>  " .."</span>" .. "<span font='" .. beautiful.icon_font .. "10'" .. "background='" .. beautiful.lighter_bg .. "'foreground='" .. beautiful.xcolor3 .. "'> " .. used .."% </span>")
end)

-- }}

-- {{ weather
-- local awful = require("awful")
-- local wibox = require("wibox")
-- local gears = require("gears")
-- local beautiful = require("beautiful")
-- local dpi = beautiful.xresources.apply_dpi
local filesystem = gears.filesystem
local json = require("modules.json")
-- local user_vars = require("user_variables")
local icon_dir = filesystem.get_configuration_dir() .. "ui/panels/info-panel/weather/icons/"

--- Weather Widget
--- ~~~~~~~~~~~~~~

local GET_FORECAST_CMD = [[bash -c "curl -s --show-error -X GET '%s'"]]

local icon_map = {
	["01d"] = "weather-clear-sky",
	["02d"] = "weather-few-clouds",
	["03d"] = "weather-clouds",
	["04d"] = "weather-few-clouds",
	["09d"] = "weather-showers-scattered",
	["10d"] = "weather-showers",
	["11d"] = "weather-strom",
	["13d"] = "weather-snow",
	["50d"] = "weather-fog",
	["01n"] = "weather-clear-night",
	["02n"] = "weather-few-clouds-night",
	["03n"] = "weather-clouds-night",
	["04n"] = "weather-clouds-night",
	["09n"] = "weather-showers-scattered",
	["10n"] = "weather-showers",
	["11n"] = "weather-strom",
	["13n"] = "weather-snow",
	["50n"] = "weather-fog",
}

local current_weather_widget = wibox.widget({
	{
		{
			id = "icon",
			image = icon_dir .. "weather-showers.svg",
			resize = true,
			forced_height = dpi(42),
			forced_width = dpi(42),
			widget = wibox.widget.imagebox,
		},
		{
			{
				{
					id = "description",
					text = "Mostly cloudy",
					font = beautiful.font_name .. "Bold 10",
					widget = wibox.widget.textbox,
				},
				{
					id = "humidity",
					text = "Humidity: 80%",
					font = beautiful.font_name .. "Light 9",
					widget = wibox.widget.textbox,
				},
				layout = wibox.layout.fixed.vertical,
			},
			widget = wibox.container.place,
		},
		spacing = dpi(10),
		layout = wibox.layout.fixed.horizontal,
	},
	nil,
	{
		{
			{
				id = "tempareture_current",
				markup = "20<sup><span>°</span></sup>",
				align = "right",
				font = beautiful.font_name .. "Bold 16",
				widget = wibox.widget.textbox,
			},
			{
				id = "feels_like",
				markup = "Feels like: 19<sup><span>°</span></sup>",
				font = beautiful.font_name .. "Light 8",
				widget = wibox.widget.textbox,
			},
			spacing = dpi(-6),
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.place,
	},
	layout = wibox.layout.align.horizontal,
})

local hourly_widget = function()
	local widget = wibox.widget({
		{
			{
				id = "time",
				text = "12PM",
				font = beautiful.font_name .. "Light 9",
				widget = wibox.widget.textbox,
			},
			widget = wibox.container.place,
		},
		{
			{
				id = "icon",
				image = icon_dir .. "weather-clear-sky.svg",
				resize = true,
				forced_height = dpi(16),
				forced_width = dpi(16),
				widget = wibox.widget.imagebox,
			},
			widget = wibox.container.place,
		},
		{
			{
				id = "tempareture",
				markup = "1<sup><span>°</span></sup>",
				font = beautiful.font_name .. "Light 9",
				widget = wibox.widget.textbox,
			},
			widget = wibox.container.place,
		},
		spacing = dpi(6),
		layout = wibox.layout.fixed.vertical,
	})

	widget.update = function(result)
		local time = widget:get_children_by_id("time")[1]
		local icon = widget:get_children_by_id("icon")[1]
		local temp = widget:get_children_by_id("tempareture")[1]
		temp:set_markup(math.floor(result.temp) .. "<sup><span>°</span></sup>")
		time:set_text(os.date("%I%p", tonumber(result.dt)))
		icon.image = icon_dir .. icon_map[result.weather[1].icon] .. ".svg"
		icon:emit_signal("widget::redraw_needed")
	end
	return widget
end

local hourly_widget_1 = hourly_widget()
local hourly_widget_2 = hourly_widget()
local hourly_widget_3 = hourly_widget()
local hourly_widget_4 = hourly_widget()
local hourly_widget_5 = hourly_widget()
local hourly_widget_6 = hourly_widget()

local weather_widget = wibox.widget({
	{
		text = "Weather",
		font = beautiful.font_name .. "Bold 16",
		align = "center",
		widget = wibox.widget.textbox,
	},
	current_weather_widget,
	{
		hourly_widget_1,
		hourly_widget_2,
		hourly_widget_3,
		hourly_widget_4,
		hourly_widget_5,
		hourly_widget_6,
		spacing = dpi(10),
		layout = wibox.layout.flex.horizontal,
	},
	spacing = dpi(10),
	layout = wibox.layout.fixed.vertical,
})

local api_key = "d1b3b6a81db867259446b0863d5f9108"
local coordinates = {
    "25.6", --- lat
    "85.1167", --- lon
}

local show_hourly_forecast = true
local show_daily_forecast = true
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
	.. (show_hourly_forecast == false and ",hourly" or "")
	.. (show_daily_forecast == false and ",daily" or "")
)

awful.widget.watch(string.format(GET_FORECAST_CMD, url), 600, function(_, stdout, stderr)
	if stderr == "" then
		local result = json.decode(stdout)
		-- Current weather setup
		local icon = current_weather_widget:get_children_by_id("icon")[1]
		local description = current_weather_widget:get_children_by_id("description")[1]
		local humidity = current_weather_widget:get_children_by_id("humidity")[1]
		local temp_current = current_weather_widget:get_children_by_id("tempareture_current")[1]
		local feels_like = current_weather_widget:get_children_by_id("feels_like")[1]
		icon.image = icon_dir .. icon_map[result.current.weather[1].icon] .. ".svg"
		icon:emit_signal("widget::redraw_needed")
		description:set_text(result.current.weather[1].description:gsub("^%l", string.upper))
		humidity:set_text("Humidity: " .. result.current.humidity .. "%")
		temp_current:set_markup(math.floor(result.current.temp) .. "<sup><span>°</span></sup>")
		feels_like:set_markup("Feels like: " .. math.floor(result.current.feels_like) .. "<sup><span>°</span></sup>")
		-- Hourly widget setup
		hourly_widget_1.update(result.hourly[1])
		hourly_widget_2.update(result.hourly[2])
		hourly_widget_3.update(result.hourly[3])
		hourly_widget_4.update(result.hourly[4])
		hourly_widget_5.update(result.hourly[5])
		hourly_widget_6.update(result.hourly[6])
	end
end)
-- }}


-- Weather widget
-- local tempicon = wibox.widget.textbox()
-- tempicon:set_markup(markup.fontbg(beautiful.icon_font .. "12", beautiful.xcolor10, "  "))
-- local myWeather =
--     lain.widget.weather(
--     {
--         APPID = "d1b3b6a81db867259446b0863d5f9108",
--         city_id = 1260086,
--         settings = function()
--             descr = weather_now["weather"][1]["description"]:lower()
--             units = math.floor(weather_now["main"]["temp"])
--             widget:set_markup(
--                 markup.fontfg(beautiful.icon_font .. "10", beautiful.xcolor2, " " .. descr .. ", " .. units .. "°C ")
--             )
--         end
--     }
-- )
-- local weatherWibox = makeWidget(tempicon, myWeather, beautiful.lighter_bg, beautiful.darker_bg)

-- -- Keyboard map indicator and switcher
-- local keyboardText =
--     wibox.widget {
--     font = beautiful.icon_font .. "11",
--     markup = "<span background='" ..
--         beautiful.xcolor13 .. "'" .. "foreground='" .. beautiful.darker_bg .. "'>   " .. "</span>",
--     widget = wibox.widget.textbox
-- }
-- beautiful.mykeyboardlayout = awful.widget.keyboardlayout()
-- local keyboardWibox = makeWidget(keyboardText, beautiful.mykeyboardlayout, beautiful.xcolor5, beautiful.darker_bg)

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
            layout = wibox.layout.align.horizontal,
            expand = "none",
            {
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
                s.mypromptbox,
                separator,
                s.mytasklist
            },
            {
                layout = wibox.layout.fixed.horizontal,
                -- weatherWibox,
                current_weather_widget
            },
            {
                -- keyboardWibox,
                memWidget,
                separator,
                -- memWibox,
                cpuWidget,
                separator,
                -- cpuWibox,
                clockWidget,
                separator,
                -- clockWibox,
                {
                    mysystray,
                    top = dpi(3),
                    bottom = dpi(3),
                    -- left = dpi(10),
                    right = dpi(5),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal
            }
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
        awful.key(
            {},
            "XF86AudioRaiseVolume",
            function()
                awful.util.spawn("amixer -D pipewire sset Master 5%+", false)
            end
        ),
        awful.key(
            {},
            "XF86AudioLowerVolume",
            function()
                awful.util.spawn("amixer -D pipewire sset Master 5%-", false)
            end
        ),
        awful.key(
            {},
            "XF86AudioMute",
            function()
                awful.util.spawn("amixer -D pipewire sset Master toggle", false)
            end
        )
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
                instance = {"copyq", "pinentry"},
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Gpick",
                    "Kruler",
                    "Sxiv",
                    "Tor Browser",
                    "Wpa_gui",
                    "veromix",
                    "xtightvncviewer"
                },
                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Event Tester" -- xev.
                },
                role = {
                    "AlarmWindow", -- Thunderbird's calendar.
                    "ConfigManager", -- Thunderbird's about:config.
                    "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = {floating = true}
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
run_once({"volumeicon", "picom", "clipmenud"}) -- comma-separated entries

-- EOF ------------------------------------------------------------------------
