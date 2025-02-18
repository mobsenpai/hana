{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf optional optionals getExe getExe';
  inherit (config.modules.colorScheme) xcolors;
  cfg = config.modules.programs.waybar;
  desktopCfg = config.modules.desktop;
  isHyprland = desktopCfg.windowManager == "Hyprland";
  isLaptop = osConfig.modules.system.device.type == "laptop";
in
  mkIf cfg.enable
  {
    services = {
      blueman-applet.enable = true;
      network-manager-applet.enable = true;
      udiskie = {
        enable = true;
        settings = {
          program_options = {
            # https://github.com/nix-community/home-manager/issues/632
            file_manager = "pcmanfm";
          };
        };
      };
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings = {
        bar = let
          formatIcon = bg: fg: icon: "<span line_height='1.2' background='${bg}' foreground='${fg}'> ${icon} </span>";
        in {
          exclusive = true;
          fixed-center = true;
          layer = "top";
          position = "top";
          spacing = 8;

          modules-left =
            optionals isHyprland
            [
              "hyprland/workspaces"
              "hyprland/window"
            ];
          modules-center = ["custom/playerctl"];
          modules-right = ["custom/weather" "memory" "cpu" "clock" "group/systray" "custom/notification"];

          backlight = let
            brightnessctl = getExe pkgs.brightnessctl;
          in
            mkIf isLaptop {
              format = "<span line_height='1.2'> {icon} </span>";
              format-icons = ["󰃞" "󰃟" "󰃠"];
              on-scroll-up = "${brightnessctl} set +1%";
              on-scroll-down = "${brightnessctl} set 1%-";
              tooltip-format = "Backlight: {percent}%";
            };

          battery = mkIf isLaptop {
            format = "<span line_height='1.2'> {icon} </span>";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            tooltip-format = "{timeTo}, {capacity}%";
          };

          clock = {
            format = formatIcon xcolors.blue1 xcolors.bg0 "" + " {:%a %b %d - %I:%M %p}";
            format-alt = formatIcon xcolors.blue1 xcolors.bg0 "" + " {:%H:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          cpu = {
            format = formatIcon xcolors.yellow1 xcolors.bg0 "" + " {usage}%";
          };

          "custom/trayicon" = {
            format = formatIcon xcolors.red0 xcolors.bg0 "󱊔";
            tooltip = false;
          };

          "custom/notification" = let
            swaync = getExe' config.services.swaync.package "swaync-client";
          in {
            exec = "${swaync} -swb";
            return-type = "json";
            format = "<span line_height='1.2'> {icon} </span>";
            format-icons = {
              notification = "󱥂";
              none = "󰍥";
              dnd-notification = "󱅯";
              dnd-none = "󱙎";
              inhibited-notification = "󱅯";
              inhibited-none = "󱙎";
              dnd-inhibited-notification = "󱅯";
              dnd-inhibited-none = "󱙎";
            };
            on-click = "${swaync} -t -sw";
            on-click-right = "${swaync} -d -sw";
            tooltip = true;
            escape = true;
          };

          "custom/playerctl" = let
            playerctl = getExe pkgs.playerctl;
          in {
            exec = "${playerctl} -a metadata --format '{\"text\": \"{{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
            format = formatIcon xcolors.purple1 xcolors.bg0 "{icon}" + " {}";
            format-icons = {
              "Paused" = "";
              "Playing" = "󰎈";
            };
            max-length = 20;
            on-click = "${playerctl} play-pause";
            on-click-middle = "${playerctl} previous";
            on-click-right = "${playerctl} next";
            return-type = "json";
          };

          "custom/weather" = let
            wttrbar = getExe pkgs.wttrbar;
          in {
            exec = "${wttrbar} --location Bihar --custom-indicator \"{temp_C} °C\"";
            format = formatIcon xcolors.green1 xcolors.bg0 "" + " {}";
            tooltip = true;
            interval = 3600;
            return-type = "json";
          };

          "group/systray" = {
            orientation = "inherit";
            modules =
              [
                "custom/trayicon"
                "pulseaudio"
                "backlight"
              ]
              ++ optional isLaptop "battery"
              ++ ["tray"];
          };

          "hyprland/workspaces" = mkIf isHyprland {
            format = "{name}";
            on-click = "activate";
            disable-scroll = true;
          };

          "hyprland/window" = mkIf isHyprland {
            format = "{title}";
            max-length = 40;
            seperate-outputs = true;
          };

          memory = {
            format = formatIcon xcolors.aqua1 xcolors.bg0 "" + " {used:0.1f} G";
          };

          pulseaudio = let
            pamixer = getExe pkgs.pamixer;
          in {
            format = "<span line_height='1.2'> {icon} </span>";
            format-bluetooth = " 󰂯 ";
            format-muted = " 󰖁 ";
            format-icons = {
              hands-free = "󱡏";
              headphone = "󰋋";
              headset = "󰋎";
              default = ["󰖀" "󰕾" "󰕾"];
            };
            tooltip-format = "Volume: {volume}%";
            on-click = "${pamixer} --toggle-mute";
          };

          tray = {
            reverse-direction = true;
            spacing = 4;
          };
        };
      };

      style =
        /*
        css
        */
        ''
          * {
            all: unset;
            font-family: "FiraMono Nerd Font";
            font-size: 10pt;
            font-weight: normal;
          }

          window#waybar {
            background: ${xcolors.bg0};
            border: 1px solid ${xcolors.bg2};
            color: ${xcolors.fg1};
          }

          window#waybar > box {
            padding: 3px;
          }

          #clock {
            background: ${xcolors.blue0};
            color: ${xcolors.fg0};
            padding-right: 6px;
          }

          #cpu {
            background: ${xcolors.bg1};
            color: ${xcolors.yellow0};
            padding-right: 6px;
          }

          #custom-playerctl {
            background: ${xcolors.bg1};
            color: ${xcolors.purple0};
            padding-right:6px;
          }

          #custom-weather {
            background: ${xcolors.bg1};
            color: ${xcolors.green0};
            padding-right: 6px;
          }

          #memory {
            background: ${xcolors.aqua0};
            color: ${xcolors.bg1};
            padding-right: 6px;
          }

          #systray {
            background: ${xcolors.bg1};
            padding-right: 6px;
          }

          #info,
          #workspaces,
          #window{
            background: ${xcolors.bg0};
          }

          #workspaces button {
            background: ${xcolors.bg0};
            color: ${xcolors.gray1};
            padding: 0 6px;
          }

          #workspaces button.active {
            background: ${xcolors.orange1};
            color: ${xcolors.bg0};
          }

          #workspaces button.urgent {
            background: ${xcolors.red1};
            color: ${xcolors.fg1};
          }

          #window {
            color: ${xcolors.green0};
          }

          tooltip,
          #tray menu {
            background: ${xcolors.bg1};
            border: 1px solid ${xcolors.bg2};
            border-radius: 8px;
            color: ${xcolors.fg1};
          }

          #tray menu {
            padding: 4px;
          }

          #tray menu separator {
            background: ${xcolors.bg2};
          }

          #tray menu menuitem {
            border-radius: 4px;
            color: ${xcolors.fg1};
            padding: 4px;
          }

          #tray menu menuitem:hover {
            background: ${xcolors.bg2};
            color: ${xcolors.fg1};
          }
        '';
    };
  }
