{
  lib,
  config,
  ...
}: let
  inherit (config.modules.colorScheme) xcolors;
  cfg = config.modules.services.swaync;
in
  lib.mkIf cfg.enable
  {
    services.swaync = {
      enable = true;
      settings = {
        control-center-margin-top = 10;
        control-center-margin-bottom = 10;
        control-center-margin-right = 10;
        control-center-margin-left = 10;
        control-center-positionX = "right";
        control-center-width = 400;
        fit-to-screen = true;
        hide-on-clear = true;
        hide-on-action = true;
        image-visibility = "when-available";
        keyboard-shortcuts = true;
        layer = "overlay";
        notification-icon-size = 40;
        notification-body-image-height = 40;
        notification-body-image-width = 40;
        notification-window-width = 350;
        positionX = "center";
        positionY = "top";
        script-fail-notify = true;
        timeout = 3;
        timeout-low = 2;
        timeout-critical = 0;
        transition-time = 200;
        widgets = ["title" "dnd" "notifications"];
        widget-config = {
          "dnd" = {
            "text" = "Do not disturb";
          };
          "title" = {
            "button-text" = "Clear all";
            "clear-all-button" = true;
            "text" = "Notifications";
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

          .notification {
            background: ${xcolors.base01};
            border: 1px solid ${xcolors.base02};
            border-radius: 8px;
            padding: 7px;
          }

          .notification-content {
            background: ${xcolors.base01};
            color: ${xcolors.base05};
          }

          .notification .image {
            margin-right: 8px;
          }

          .notification-row {
            margin: 2px;
          }

          progressbar {
            background: ${xcolors.base00};
            border-radius: 2px;
          }

          progress {
            background: ${xcolors.base09};
            border-radius: 2px;
          }

          .close-button {
            background: ${xcolors.base08};
            border-radius: 50%;
            color: ${xcolors.base00};
          }

          .close-button:hover {
            background: ${xcolors.base08};
            transition: 200ms;
          }

          .time {
            color: ${xcolors.base0B};
            font-size: 9pt;
            margin-right: 24px;
          }

          .control-center {
            background: ${xcolors.base01};
            border: 1px solid ${xcolors.base02};
            border-radius: 8px;
            padding: 8px;
          }

          .control-center-list-placeholder {
            background: ${xcolors.base01};
            color: ${xcolors.base04};
          }

          .control-center .notification-group {
            color: ${xcolors.base05};
          }

          .widget-title {
            background: ${xcolors.base01};
            color: ${xcolors.base05};
            margin-bottom: 8px;
          }

          .widget-title > button {
            background: ${xcolors.base0B};
            color: ${xcolors.base00};
            border-radius: 4px;
            padding: 2px;
          }

          .widget-title > button:hover {
            background: ${xcolors.base14};
            color: ${xcolors.base00};
            transition: 200ms;
          }

          .widget-dnd {
            background: ${xcolors.base01};
            color: ${xcolors.base05};
          }

          .widget-dnd > switch {
            background: ${xcolors.base03};
            border-radius: 4px;
          }

          .widget-dnd > switch:checked {
            background: ${xcolors.base09};
          }

          .widget-dnd > switch slider {
            background: ${xcolors.base00};
            border-radius: 4px;
          }
        '';
    };
  }
