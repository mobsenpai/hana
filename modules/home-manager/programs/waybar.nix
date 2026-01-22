{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf optional getExe getExe';
  inherit (config.modules.colorScheme) xcolors;
  inherit (osConfig.modules.system) audio device;
  inherit (config.modules.desktop) windowManager;
  cfg = config.modules.programs.waybar;

  swaync = getExe' config.services.swaync.package "swaync-client";
  pwvu = getExe pkgs.pwvucontrol;
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
        bar = {
          exclusive = true;
          fixed-center = true;
          layer = "top";
          position = "bottom";
          spacing = 8;
          height = 27;

          modules-left =
            optional (windowManager == "Niri") "niri/workspaces"
            ++ optional (windowManager == "Hyprland") "hyprland/workspaces";

          modules-center =
            optional (windowManager == "Niri") "niri/window"
            ++ optional (windowManager == "Hyprland") "hyprland/window";

          modules-right =
            optional (audio.enable) "wireplumber"
            ++ optional (device.type == "laptop") "battery"
            ++ [
              "clock"
              "custom/notification"
              "tray"
            ];

          battery = mkIf (device.type == "laptop") {
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% {icon}";
            format-plugged = "{capacity}% 󰚥";
            format-icons = {
              default = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
              charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            };
            tooltip-format = "{timeTo}, {capacity}%";
          };

          clock = {
            format = "{:%I:%M %p %d/%m/%Y}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          "custom/notification" = {
            exec = "${swaync} -swb";
            return-type = "json";
            format = "{icon}";
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

          "niri/workspaces" = mkIf (windowManager == "Niri") {
            format = "{index}";
            on-click = "activate";
            disable-scroll = true;
          };

          "niri/window" = mkIf (windowManager == "Niri") {
            format = "{title}";
            max-length = 40;
            separate-outputs = true;
          };

          "hyprland/workspaces" = mkIf (windowManager == "Hyprland") {
            format = "{name}";
            on-click = "activate";
            disable-scroll = true;
          };

          "hyprland/window" = mkIf (windowManager == "Hyprland") {
            format = "{title}";
            max-length = 40;
            separate-outputs = true;
          };

          tray = {
            reverse-direction = true;
            spacing = 4;
          };

          "wireplumber" = mkIf audio.enable {
            format = "{volume}% {icon} {format_source}";
            format-muted = "󰖁 {format_source}";
            format-source = "{volume}% 󰍬";
            format-source-muted = "󰍭";
            format-icons = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            tooltip-format = "Output: {node_name}\nInput: {source_desc}";
            tooltip = true;
            on-click = pwvu;
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
            background: ${xcolors.base00};
            border: 1px solid ${xcolors.base02};
            color: ${xcolors.base05};
          }

          window#waybar > box {
            padding: 3px;
          }

          #battery,
          #clock,
          #custom-notification,
          #window,
          #wireplumber {
            background: ${xcolors.base00};
            color: ${xcolors.base05};
            padding-right: 4px;
          }

          #workspaces {
            background: ${xcolors.base00};
          }

          #workspaces button {
            background: ${xcolors.base00};
            color: ${xcolors.base05};
            padding: 0 5px;
            border-bottom: 2px solid transparent;
          }

          #workspaces button.active {
            background: ${xcolors.base02};
            border-bottom: 2px solid ${xcolors.base0D};
          }

          #workspaces button.urgent {
            background: ${xcolors.base08};
            color: ${xcolors.base05};
          }

          #window {
            color: ${xcolors.base05};
          }

          tooltip,
          #tray menu {
            background: ${xcolors.base01};
            border: 1px solid ${xcolors.base02};
            border-radius: 8px;
            color: ${xcolors.base05};
          }

          #tray menu {
            padding: 4px;
          }

          #tray menu separator {
            background: ${xcolors.base02};
          }

          #tray menu menuitem {
            border-radius: 4px;
            color: ${xcolors.base05};
            padding: 4px;
          }

          #tray menu menuitem:hover {
            background: ${xcolors.base02};
            color: ${xcolors.base05};
          }
        '';
    };

    # Removing black corner on waybar
    # https://github.com/YaLTeR/niri/discussions/1668
    desktop.niri.settings = {
      layer-rules = [
        {
          matches = [{namespace = "waybar";}];
          opacity = 0.99;
        }
      ];
    };
  }
