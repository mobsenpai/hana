{
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf filter;
  inherit (config.modules.colorScheme) colors;
  inherit (config.modules.desktop) windowManager;
  osDesktop = osConfig.modules.system.desktop;
  enabledMonitors = filter (m: m.enabled) osConfig.modules.system.device.monitors;

  dynamicMonitors =
    map
    (monitor: "${monitor.name},${toString monitor.width}x${toString monitor.height}@${toString (monitor.refreshRate * 1000)},${toString monitor.position.x}x${toString monitor.position.y},${toString monitor.scale}")
    enabledMonitors;
in
  mkIf (osDesktop.enable && windowManager == "Hyprland")
  {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
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
            enabled = false;
          };

          shadow = {
            enabled = true;
            color = "rgba(00000055)";
            offset = "0 2";
            range = 20;
            render_power = 3;
          };

          rounding = 0;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        general = {
          border_size = 1;
          "col.active_border" = "rgb(${colors.base0D})";
          "col.inactive_border" = "rgb(${colors.base02})";
          gaps_in = 6;
          gaps_out = 6;
          layout = "master";
          no_focus_fallback = true;
        };

        input = {
          kb_layout = "us";
          accel_profile = "adaptive";
          scroll_method = "2fg";
          touchpad = {
            natural_scroll = true;
            tap-to-click = true;
            middle_button_emulation = true;
            clickfinger_behavior = 1;
          };
        };

        master = {
          new_status = "master";
          mfact = 0.5;
          new_on_top = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          focus_on_activate = true;
          force_default_wallpaper = 0;
          new_window_takes_over_fullscreen = 2;
        };

        monitor = dynamicMonitors;

        windowrule = [
          "float,class:^(yad)$"
        ];

        xwayland = {
          force_zero_scaling = true;
        };
      };
    };
  }
