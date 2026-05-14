{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe getExe' filter utils head singleton optional;
  inherit (config.modules.colorScheme) colors;
  inherit (config.modules.desktop) wallpaper;
  inherit (config.modules.desktop.style) font;
  inherit (osConfig.modules.system.device) monitors;
  inherit (osConfig.modules.system) device;
  cfg = config.modules.programs.hyprlock;

  primaryMonitor = head (filter (m: m.isPrimary) monitors);
  labelHeight = builtins.ceil (0.035 * primaryMonitor.height * primaryMonitor.scale);
  labelWidth = builtins.ceil (0.03 * primaryMonitor.width / primaryMonitor.scale);
  getBattery = pkgs.writeShellScript "hyprlock-battery" ''
    if [ -f /sys/class/power_supply/${device.battery}/capacity ]; then
      pct=$(cat /sys/class/power_supply/${device.battery}/capacity)
      status=$(cat /sys/class/power_supply/${device.battery}/status)
      defaultIcons=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
      chargingIcons=("󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")
      idx=$((pct / 10))
      [ $idx -gt 10 ] && idx=10
      case "$status" in
        Charging) icon=''${chargingIcons[$idx]} ;;
        *)        icon=''${defaultIcons[$idx]}   ;;
      esac
      echo "$pct% $icon"
    fi
  '';
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

        input-field =
          singleton
          {
            monitor = "";
            size = "${
              toString (builtins.ceil (0.175 * primaryMonitor.width * primaryMonitor.scale))
            }, ${toString labelHeight}";
            outline_thickness = 0;
            dots_size = 0.25;
            dots_spacing = 0.25;
            dots_center = true;
            inner_color = "rgba(0,0,0,0)";
            outer_color = "rgba(0,0,0,0)";
            font_color = "rgb(${colors.base05})";
            font_family = font.family;
            fail_text = "<i>$FAIL</i>";
            fade_on_empty = true;
            placeholder_text = "";
            hide_input = false;
            rounding = -1;
            position = "0, -${toString labelHeight}";
            halign = "center";
            valign = "center";
            check_color = "rgba(0,0,0,0)";
            fail_color = "rgba(0,0,0,0)";
          };

        label = let
          playerctl = getExe pkgs.playerctl;
        in
          [
            {
              monitor = "";
              text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
              color = "rgb(${colors.base05})";
              font_size = builtins.ceil (0.047 * primaryMonitor.width * primaryMonitor.scale);
              font_family = "${font.family} Bold";
              position = "0, ${toString (2 * labelHeight)}";
              halign = "center";
              valign = "center";
              shadow_passes = 5;
              shadow_size = 10;
            }

            {
              monitor = "";
              text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
              color = "rgb(${colors.base05})";
              font_size = builtins.ceil (0.00868 * primaryMonitor.width * primaryMonitor.scale);
              font_family = font.family;
              position = "0, 0";
              halign = "center";
              valign = "center";
              shadow_passes = 5;
              shadow_size = 10;
            }

            {
              monitor = "";
              text = "cmd[update:1000] sh -c 'title=$(${playerctl} metadata title 2>/dev/null); [ -n \"$title\" ] && echo \"$title\" | cut -c 1-60 || echo \"\"'";
              color = "rgb(${colors.base05})";
              font_size = builtins.ceil (0.006 * primaryMonitor.width * primaryMonitor.scale);
              font_family = font.family;
              position = "0, ${toString labelHeight}";
              halign = "center";
              valign = "bottom";
            }
          ]
          ++ optional (device.type == "laptop") {
            monitor = "";
            text = "cmd[update:1000] ${getBattery}";
            color = "rgb(${colors.base05})";
            font_size = builtins.ceil (0.005 * primaryMonitor.width * primaryMonitor.scale);
            font_family = font.family;
            position = "-${toString labelWidth}, ${toString labelHeight}";
            halign = "right";
            valign = "bottom";
          };
      };
    };

    desktop = let
      loginctl = getExe' pkgs.systemd "loginctl";
    in {
      niri.binds = with config.lib.niri.actions; {
        "Mod+Alt+Period" = {
          action = spawn loginctl "lock-session";
          hotkey-overlay.title = "Lock Screen";
        };
      };

      hyprland.binds = [
        "SUPER ALT, Period, Lock Screen, exec, ${loginctl} lock-session"
      ];
    };
  }
