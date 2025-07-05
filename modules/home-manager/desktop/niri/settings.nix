# TODO
# 1. fix the black corners
{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.colorScheme) xcolors;
  inherit (config.modules.desktop) windowManager;
  osDesktop = osConfig.modules.system.desktop;
in
  mkIf (osDesktop.enable && windowManager == "Niri") {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
      settings = {
        gestures = {hot-corners.enable = true;};
        hotkey-overlay.skip-at-startup = true;
        input = {
          keyboard.xkb.layout = "us";
          touchpad = {
            accel-profile = "adaptive";
            click-method = "button-areas";
            dwt = true;
            dwtp = true;
            middle-emulation = true;
            natural-scroll = false;
            scroll-method = "two-finger";
            tap = true;
            tap-button-map = "left-right-middle";
          };

          focus-follows-mouse.enable = true;
          warp-mouse-to-focus.enable = true;
          workspace-auto-back-and-forth = true;
        };

        layout = {
          border = {
            active.color = xcolors.base0D;
            enable = true;
            inactive.color = xcolors.base02;
            width = 1;
          };

          default-column-width = {proportion = 0.5;};
          focus-ring.enable = false;
          gaps = 6;
          preset-column-widths = [
            {proportion = 0.25;}
            {proportion = 0.5;}
            {proportion = 0.75;}
            {proportion = 1.0;}
          ];

          shadow = {enable = true;};
          struts = {
            bottom = 0;
            left = 0;
            right = 0;
            top = 0;
          };

          tab-indicator = {
            corner-radius = 20.0;
            enable = true;
            gap = -12.0;
            gaps-between-tabs = 10.0;
            hide-when-single-tab = true;
            length.total-proportion = 0.1;
            place-within-column = true;
            position = "left";
            width = 4.0;
          };
        };

        outputs = {
          "eDP-1" = {
            position = {
              x = 0;
              y = 0;
            };
            scale = 1.0;
          };

          "HDMI-A-1" = {
            mode = {
              height = 768;
              refresh = null;
              width = 1366;
            };
            position = {
              x = 0;
              y = 0;
            };
            scale = 1.0;
          };
        };

        overview = {
          backdrop-color = "transparent";
        };

        prefer-no-csd = true;
        screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";
      };
    };
  }
