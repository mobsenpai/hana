{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf optional getExe getExe';
  inherit (config.modules.colorScheme) xcolors;
  inherit (osConfig.modules.system) device;
  inherit (config.modules.desktop) windowManager;
  cfg = config.modules.programs.waybar;

  swaync = getExe' config.services.swaync.package "swaync-client";
  wpctl = getExe' pkgs.wireplumber "wpctl";
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
            ["pulseaudio"]
            ++ optional (device.type == "laptop") "battery"
            ++ [
              "clock"
              "custom/notification"
              "tray"
            ];

          battery = mkIf (device.type == "laptop") {
            format = "{capacity}% {icon}";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            tooltip-format = "{timeTo}, {capacity}%";
          };

          clock = {
            format = "{:%H:%M %d/%m/%Y}";
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

          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon}󰂯 {format_source}";
            format-muted = " 󰖁 {format_source}";
            format-bluetooth-muted = "󰖁 {icon}󰂯 {format_source}";
            format-source = "{volume}% 󰍬";
            format-source-muted = "󰍭";
            format-icons = {
              hands-free = "󱡏";
              headphone = "󰋋";
              headset = "󰋎";
              default = ["󰕿" "󰖀" "󰕾"];
            };
            tooltip-format = "Output: {desc}\nInput: {source_desc}";
            on-click = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = "${pwvu}";
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

          #battery,
          #clock,
          #custom-notification,
          #window,
          #pulseaudio {
            background: ${xcolors.bg0};
            color: ${xcolors.fg1};
          }

          #custom-notification {
            padding-right: 4px;
          }

          #workspaces {
            background: ${xcolors.bg0};
          }

          #workspaces button {
            background: ${xcolors.bg0};
            color: ${xcolors.gray1};
            padding: 0 5px;
            border-bottom: 2px solid transparent;
          }

          #workspaces button.active {
            background: ${xcolors.bg2};
            border-bottom: 2px solid ${xcolors.blue1};
          }

          #workspaces button.urgent {
            background: ${xcolors.red1};
            color: ${xcolors.fg1};
          }

          #window {
            color: ${xcolors.fg1};
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
