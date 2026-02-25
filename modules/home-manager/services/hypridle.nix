{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf utils getExe getExe' optional;
  inherit (config.modules.desktop) windowManager;
  cfg = config.modules.services.hypridle;
in
  mkIf cfg.enable
  {
    assertions = utils.asserts [
      (config.programs.hyprlock.enable)
      "Hyidle requires hyprlock to be enabled"
    ];

    services.hypridle = {
      enable = true;
      settings = let
        loginctl = getExe' pkgs.systemd "loginctl";
        hyprlock = getExe config.programs.hyprlock.package;
        hyprctl = getExe' config.wayland.windowManager.hyprland.package "hyprctl";
        niri = getExe' config.programs.niri.package "niri";
        systemctl = getExe' pkgs.systemd "systemctl";
        brightnessctl = getExe pkgs.brightnessctl;
        pidof = getExe' pkgs.procps "pidof";
      in {
        general = {
          after_sleep_cmd =
            if windowManager == "Hyprland"
            then "${hyprctl} dispatch dpms on"
            else if windowManager == "Niri"
            then "${niri} msg action power-on-monitors"
            else null;

          before_sleep_cmd = "${loginctl} lock-session";
          lock_cmd = "${pidof} hyprlock || ${hyprlock}";
        };

        listener =
          [
            {
              timeout = 270;
              on-timeout = "${brightnessctl} -s set 10%";
              on-resume = "${brightnessctl} -r";
            }
            {
              timeout = 300;
              on-timeout = "${loginctl} lock-session";
            }
          ]
          # NOTE: high resolution monitors causes a black screen
          # have to switch to a tty and then back
          ++ optional (windowManager == "Hyprland") {
            timeout = 330;
            on-timeout = "${hyprctl} dispatch dpms off";
            on-resume = "${hyprctl} dispatch dpms on";
          }
          ++ optional (windowManager == "Niri") {
            timeout = 330;
            on-timeout = "${niri} msg action power-off-monitors";
            on-resume = "${niri} msg action power-on-monitors";
          }
          ++ [
            {
              timeout = 600;
              on-timeout = "${systemctl} suspend";
            }
          ];
      };
    };

    desktop = let
      systemctl = getExe' pkgs.systemd "systemctl";
      notifySend = getExe pkgs.libnotify;
      toggleHypridle = pkgs.writeShellScript "hypridle-toggle" ''
        ${systemctl} is-active --quiet --user hypridle && {
          ${systemctl} stop --quiet --user hypridle
          ${notifySend} --urgency=low -t 2000 'Hypridle' 'Service disabled'
        } || {
          ${systemctl} start --quiet --user hypridle
          ${notifySend} --urgency=low -t 2000 'Hypridle' 'Service enabled'
        }
      '';
    in {
      niri.binds = {
        "Mod+U" = {
          action.spawn = "${toggleHypridle}";
          hotkey-overlay.title = "Toggle hypridle";
        };
      };

      hyprland.binds = [
        "SUPER, U,  Toggle hypridle, exec, ${toggleHypridle}"
      ];
    };
  }
