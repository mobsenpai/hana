{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe';
  inherit (config.modules.colorScheme) colors;
  inherit (config.modules.desktop) wallpaper;
  cfg = config.modules.programs.hyprlock;
in
  mkIf cfg.enable
  {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 5;
        };

        background = [
          {
            path = wallpaper.default;
            blur_passes = 3;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            outline_thickness = 2;
            dots_size = 0.25;
            dots_spacing = 0.25;
            dots_center = true;
            outer_color = "rgb(${colors.bg0})";
            inner_color = "rgb(${colors.bg0})";
            font_color = "rgb(${colors.fg1})";
            fade_on_empty = false;
            placeholder_text = "<i>Input Password...</i>";
            hide_input = false;
            position = "0, -100";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
            color = "rgb(${colors.fg1})";
            font_size = 80;
            font_family = "FiraMono Nerd Font Bold";
            position = "0, -200";
            halign = "center";
            valign = "top";
          }
          {
            text = "Hi there, $USER";
            color = "rgb(${colors.fg1})";
            font_size = 18;
            font_family = "FiraMono Nerd Font";
            position = "0, -30";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };

    desktop = let
      loginctl = getExe' pkgs.systemd "loginctl";
    in {
      niri.binds = {
        "Mod+Alt+Period" = {
          action.spawn = [loginctl "lock-session"];
          hotkey-overlay.title = "Lock Screen";
        };
      };

      hyprland.binds = [
        "SUPER ALT, Period, exec, ${loginctl} lock-session"
      ];
    };
  }
