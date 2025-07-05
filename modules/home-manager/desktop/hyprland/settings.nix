{
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.colorScheme) colors;
  inherit (config.modules.desktop) windowManager;
  osDesktop = osConfig.modules.system.desktop;
in
  mkIf (osDesktop.enable && windowManager == "Hyprland")
  {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        general = {
          border_size = 2;
          "col.active_border" = "rgb(${colors.base0D})";
          "col.inactive_border" = "rgb(${colors.base02})";
          gaps_in = 10;
          gaps_out = 10;
          layout = "master";
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          focus_on_activate = true;
          force_default_wallpaper = 0;
          new_window_takes_over_fullscreen = 2;
        };

        input = {
          kb_layout = "us";
        };

        monitor = [
          "eDP-1, highres, 0x0, 1"
        ];

        animations = {
          enabled = true;
          bezier = [
            "overshot, 0.05, 0.9, 0.1, 1.05"
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
          ];

          animation = [
            "border, 1, 5, default"
            "fade, 1, 5, smoothIn"
            "fadeDim, 1, 5, smoothIn"
            "windows, 1, 5, overshot, slide"
            "windowsMove, 1, 4, smoothIn, slide"
            "windowsOut, 1, 4, smoothOut, slide"
            "workspaces, 1, 6, default"
          ];
        };

        decoration = {
          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            new_optimizations = true;
            ignore_opacity = false;
            xray = false;
            noise = 0.2;
            contrast = 0.9;
            brightness = 0.8;
            vibrancy = 0.15;
            vibrancy_darkness = 0.0;
            popups = true;
          };

          shadow = {
            enabled = true;
            color = "rgba(00000055)";
            offset = "0 2";
            range = 20;
            render_power = 3;
          };

          rounding = 8;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
          mfact = 0.5;
          new_on_top = true;
        };

        gestures = {
          workspace_swipe = false;
        };

        windowrule = [
          "float,class:^(yad)$"
        ];
      };
    };
  }
