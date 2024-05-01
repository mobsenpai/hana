{
  config,
  lib,
  pkgs,
  ...
}: let
  formatIcon = bg: fg: icon: "<span background='${bg}' foreground='${fg}'> ${icon} </span>";
  formatText = bg: fg: text: "<span background='${bg}' foreground='${fg}'> ${text} </span>";
in {
  options = {
    myHome.waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.myHome.waybar.enable {
    programs.waybar = with config.myHome.colorscheme; {
      enable = true;
      systemd.enable = true;
      systemd.target = "graphical-session.target";

      settings = [
        {
          exclusive = true;
          fixed-center = true;
          layer = "top";
          position = "top";
          spacing = 8;

          modules-left = ["hyprland/workspaces" "hyprland/window"];
          modules-center = ["custom/playerctl"];
          modules-right = ["custom/weather" "memory" "cpu" "clock" "group/systray" "group/info"];

          battery = {
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

          "custom/notification" = {
            exec = "${pkgs.swaynotificationcenter}/bin/swaync-client -swb";
            return-type = "json";
            format = "{icon}";
            format-icons = {
              notification = "󰂚";
              none = "󰂜";
              dnd-notification = "󰂛";
              dnd-none = "󰪑";
              inhibited-notification = "󰂛";
              inhibited-none = "󰪑";
              dnd-inhibited-notification = "󰂛";
              dnd-inhibited-none = "󰪑";
            };
            on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
            on-click-right = "${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
            tooltip = true;
            escape = true;
          };

          "custom/playerctl" = {
            exec = "${pkgs.playerctl}/bin/playerctl -a metadata --format '{\"text\": \"{{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
            format = formatIcon xcolors.purple1 xcolors.bg0 "{icon}" + formatText xcolors.bg1 xcolors.purple0 "{}";
            format-icons = {
              "Paused" = "";
              "Playing" = "󰎈";
            };
            max-length = 20;
            on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
            on-click-middle = "${pkgs.playerctl}/bin/playerctl previous";
            on-click-right = "${pkgs.playerctl}/bin/playerctl next";
            return-type = "json";
          };

          "custom/chevron" = {
            format = "";
            tooltip = false;
          };

          "custom/weather" = {
            exec = "${pkgs.wttrbar}/bin/wttrbar --location Bihar --hide-conditions";
            format = formatIcon xcolors.green1 xcolors.bg0 "" + formatText xcolors.bg1 xcolors.green0 "{}°";
            tooltip = true;
            interval = 3600;
            return-type = "json";
          };

          "group/info" = {
            orientation = "inherit";
            drawer = {
              "transition-duration" = 500;
              "transition-left-to-right" = false;
            };
            modules = [
              "custom/notification"
              "pulseaudio"
              "network"
              "battery"
            ];
          };

          "group/systray" = {
            orientation = "inherit";
            drawer = {
              "transition-duration" = 500;
              "transition-left-to-right" = false;
            };
            modules = [
              "custom/chevron"
              "tray"
            ];
          };

          "hyprland/workspaces" = {
            format = "{name}";
            on-click = "activate";
            disable-scroll = true;
          };

          "hyprland/window" = {
            format = "{title}";
            max-length = 40;
            seperate-outputs = true;
          };

          memory = {
            format = formatIcon xcolors.aqua1 xcolors.bg0 "" + formatText xcolors.aqua0 xcolors.bg1 "{}%";
          };

          network = {
            format-wifi = "󰤨";
            format-ethernet = "󰈀";
            format-disconnected = "";
            tooltip-format-wifi = "WiFi: {essid} ({signalStrength}%)\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
            tooltip-format-ethernet = "Ethernet: {ifname}\n󰅃 {bandwidthUpBytes} 󰅀 {bandwidthDownBytes}";
            tooltip-format-disconnected = "Disconnected";
            on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          };

          pulseaudio = {
            format = "{icon}";
            format-bluetooth = "󰂯";
            format-muted = "󰖁";
            format-icons = {
              hands-free = "󱡏";
              headphone = "󰋋";
              headset = "󰋎";
            };
            tooltip-format = "Volume: {volume}%";
            on-click = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
          };

          tray = {
            reverse-direction = true;
            spacing = 4;
          };
        }
      ];

      style = ''
        * {
          all: unset;
          font-family: "FiraMono Nerd Font";
          font-size: 10pt;
          font-weight: normal;
        }

        window#waybar {
          background: ${xcolors.bg0};
          color: ${xcolors.fg1};
        }

        .modules-left{
          padding-left: 4px;
        }

        .modules-right {
          padding-right: 4px;
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
          margin: 2px 0;
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
  };
}
