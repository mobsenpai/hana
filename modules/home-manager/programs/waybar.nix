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
    myhome.waybar.enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf config.myhome.waybar.enable {
    programs.waybar = with config.myhome.colorscheme; {
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
            format = formatIcon xcolors.blue xcolors.dark-black "" + formatText xcolors.dark-blue xcolors.white "{:%a %b %d - %I:%M %p}";
            format-alt = formatIcon xcolors.blue xcolors.dark-black "" + formatText xcolors.dark-blue xcolors.white "{:%H:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          cpu = {
            format = formatIcon xcolors.yellow xcolors.dark-black "" + formatText xcolors.soft-black xcolors.dark-yellow "{usage}%";
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
            format = formatIcon xcolors.purple xcolors.dark-black "{icon}" + formatText xcolors.soft-black xcolors.dark-purple "{}";
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
            format = formatIcon xcolors.green xcolors.dark-black "" + formatText xcolors.soft-black xcolors.dark-green "{}°";
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
            format = formatIcon xcolors.aqua xcolors.dark-black "" + formatText xcolors.dark-aqua xcolors.soft-black "{}%";
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

          tray = {
            reverse-direction = true;
            spacing = 4;
          };
        }
      ];

      style = ''
        * {
          all: unset;
          font-family: "Fira Mono Nerd Font";
          font-size: 10pt;
          font-weight: normal;
        }

        window#waybar {
          background: ${xcolors.black};
          color: ${xcolors.white};
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
          background: ${xcolors.black};
          margin: 2px 0;
        }

        #battery,
        #custom-notification,
        #custom-chevron,
        #network {
          padding: 0 6px;
        }

        #workspaces button {
          background: ${xcolors.black};
          color: ${xcolors.gray};
          padding: 0 6px;
        }

        #workspaces button.active {
          background: ${xcolors.orange};
          color: ${xcolors.dark-black};
        }

        #workspaces button.urgent {
          background: ${xcolors.red};
          color: ${xcolors.white};
        }

        #window {
          color: ${xcolors.dark-green};
        }

        tooltip,
        #tray menu {
          background: ${xcolors.soft-black};
          border: 1px solid ${xcolors.light-black};
          border-radius: 8px;
          color: ${xcolors.white};
        }

        #tray menu {
          padding: 4px;
        }

        #tray menu separator {
          background: ${xcolors.light-black};
        }

        #tray menu menuitem {
          border-radius: 4px;
          color: ${xcolors.white};
          padding: 4px;
        }

        #tray menu menuitem:hover {
          background: ${xcolors.light-black};
          color: ${xcolors.white};
        }
      '';
    };
  };
}
