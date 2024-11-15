{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe getExe';
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
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings = {
        bar = let
          formatIcon = bg: fg: icon: "<span line_height='1.1' background='${bg}' foreground='${fg}'> ${icon} </span>";
          formatText = bg: fg: text: "<span line_height='1.1' background='${bg}' foreground='${fg}'> ${text} </span>";
        in {
          exclusive = true;
          fixed-center = true;
          layer = "top";
          position = "top";
          spacing = 8;

          modules-left = ["hyprland/workspaces" "hyprland/window"];
          modules-center = ["custom/playerctl"];
          modules-right = ["custom/weather" "memory" "cpu" "clock" "group/systray" "custom/notification"];

          battery = mkIf isLaptop {
            format = "{icon}";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            tooltip-format = "{timeTo}, {capacity}%";
          };

          clock = {
            format = formatIcon xcolors.blue1 xcolors.bg0 "" + formatText xcolors.blue0 xcolors.fg0 "{:%a %b %d - %I:%M %p}";
            format-alt = formatIcon xcolors.blue1 xcolors.bg0 "" + formatText xcolors.blue0 xcolors.fg0 "{:%H:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          cpu = {
            format = formatIcon xcolors.yellow1 xcolors.bg0 "" + formatText xcolors.bg1 xcolors.yellow0 "{usage}%";
          };

          "custom/chevron" = {
            format = "";
            tooltip = false;
          };

          "custom/notification" = let
            swaync = getExe' config.services.swaync.package "swaync-client";
          in {
            exec = "${swaync} -swb";
            return-type = "json";
            format = "{icon}";
            format-icons = {
              notification = "󱅫";
              none = "󰂜";
              dnd-notification = "󰂛";
              dnd-none = "󰪑";
              inhibited-notification = "󰂛";
              inhibited-none = "󰪑";
              dnd-inhibited-notification = "󰂛";
              dnd-inhibited-none = "󰪑";
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
            format = formatIcon xcolors.purple1 xcolors.bg0 "{icon}" + formatText xcolors.bg1 xcolors.purple0 "{}";
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
            format = formatIcon xcolors.green1 xcolors.bg0 "" + formatText xcolors.bg1 xcolors.green0 "{}";
            tooltip = true;
            interval = 3600;
            return-type = "json";
          };

          "group/systray" = {
            orientation = "inherit";
            drawer = {
              "transition-duration" = 500;
              "transition-left-to-right" = false;
            };
            modules = [
              "custom/chevron"
              "battery"
              "tray"
            ];
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
            format = formatIcon xcolors.aqua1 xcolors.bg0 "" + formatText xcolors.aqua0 xcolors.bg1 "{}%";
          };

          network = let
            connection-editor = getExe' pkgs.networkmanagerapplet "nm-connection-editor";
          in {
            format-wifi = "󰤨";
            format-ethernet = "󰈀";
            format-disconnected = "";
            tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
            tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
            tooltip-format-disconnected = "Disconnected";
            on-click = "${connection-editor}";
          };

          pulseaudio = let
            pamixer = getExe pkgs.pamixer;
          in {
            format = "{icon}";
            format-bluetooth = "󰂯";
            format-muted = "󰖁";
            format-icons = {
              hands-free = "󱡏";
              headphone = "󰋋";
              headset = "󰋎";
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

          #clock,
          #cpu,
          #custom-playerctl,
          #custom-weather,
          #info,
          #systray,
          #workspaces,
          #window,
          #memory {
            background: ${xcolors.bg0};
          }

          #battery,
          #custom-notification,
          #custom-chevron,
          #network {
            padding: 0 6px;
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
