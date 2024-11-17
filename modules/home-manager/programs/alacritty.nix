{
  lib,
  config,
  ...
}: let
  inherit (config.modules.colorScheme) xcolors;
  cfg = config.modules.programs.alacritty;
in
  lib.mkIf cfg.enable
  {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 30;
            y = 30;
          };
          dynamic_padding = true;
          decorations = "none";
          dynamic_title = true;
        };

        font = {
          size = 10;
          normal.family = "FiraMono Nerd Font";
        };

        colors = {
          primary = {
            background = xcolors.bg0;
            foreground = xcolors.fg1;
          };

          cursor = {
            text = xcolors.bg1;
            cursor = xcolors.fg4;
          };

          selection = {
            background = xcolors.bg2;
            text = "CellForeground";
          };

          normal = {
            black = xcolors.bg0;
            red = xcolors.red0;
            green = xcolors.green0;
            yellow = xcolors.yellow0;
            blue = xcolors.blue0;
            magenta = xcolors.purple0;
            cyan = xcolors.aqua0;
            white = xcolors.gray1;
          };

          bright = {
            black = xcolors.gray0;
            red = xcolors.red1;
            green = xcolors.green1;
            yellow = xcolors.yellow1;
            blue = xcolors.blue1;
            magenta = xcolors.purple1;
            cyan = xcolors.aqua1;
            white = xcolors.fg1;
          };
        };

        mouse = {
          hide_when_typing = false;
        };

        cursor = {
          blink_interval = 500;
          style = {
            shape = "Beam";
            blinking = "On";
          };
        };
      };
    };

    desktop.hyprland.settings = {
      bind = [
        "SUPER, Return, exec, alacritty"
        "SUPER SHIFT, Return, exec, [float] alacritty"
      ];

      windowrulev2 = [
        "opacity 0.85, class:(Alacritty)"
      ];

      workspace = [
        "special:s1, on-created-empty:alacritty"
      ];
    };
  }
