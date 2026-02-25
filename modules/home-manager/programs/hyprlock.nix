{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe' utils filter head;
  inherit (config.modules.colorScheme) colors;
  inherit (config.modules.desktop) wallpaper;
  inherit (config.modules.desktop.style) font;
  inherit (osConfig.modules.system.device) monitors;
  cfg = config.modules.programs.hyprlock;

  primaryMonitor = head (filter (m: m.isPrimary) monitors);
  labelHeight = builtins.ceil (0.035 * primaryMonitor.height * primaryMonitor.scale);
in
  mkIf cfg.enable
  {
    assertions = utils.asserts [
      (builtins.any (m: m.isPrimary) monitors)
      "hyprlock: at least one monitor must be primary"
    ];

    programs.hyprlock = {
      enable = true;
      settings = {
        background = [
          {
            monitor = "";
            path = "${wallpaper}";
            blur_passes = 3;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];
        input-field = [
          {
            monitor = "";
            size = "${toString (builtins.ceil (0.12 * primaryMonitor.width * primaryMonitor.scale))}, ${toString labelHeight}";
            outline_thickness = 2;
            dots_size = 0.25;
            dots_spacing = 0.25;
            dots_center = true;
            outer_color = "rgb(${colors.base02})";
            inner_color = "rgb(${colors.base00})";
            font_color = "rgb(${colors.base05})";
            fade_on_empty = false;
            placeholder_text = "<i>Input Password...</i>";
            hide_input = false;
            position = "0, -${toString (labelHeight * 1.8)}";
            halign = "center";
            valign = "center";
          }
        ];
        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
            color = "rgb(${colors.base05})";
            font_size = builtins.ceil (0.046875 * primaryMonitor.width * primaryMonitor.scale);
            font_family = "${font.family} Bold";
            position = "0, ${toString (labelHeight * 4)}";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "Hi there, $USER";
            color = "rgb(${colors.base05})";
            font_size = builtins.ceil (0.012 * primaryMonitor.width * primaryMonitor.scale);
            font_family = font.family;
            position = "0, ${toString (labelHeight * 0)}";
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
        "SUPER ALT, Period, Lock Screen, exec, ${loginctl} lock-session"
      ];
    };
  }
