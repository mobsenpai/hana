{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe getExe';
  cfg = config.modules.services.hypridle;
  desktopCfg = config.modules.desktop;
  isHyprland = desktopCfg.windowManager == "Hyprland";
in
  mkIf cfg.enable
  {
    services.hypridle = {
      enable = true;
      settings = let
        loginctl = getExe' pkgs.systemd "loginctl";
        hyprlock = getExe pkgs.hyprlock;
        hyprctl = getExe' config.wayland.windowManager.hyprland.package "hyprctl";
        systemctl = getExe' pkgs.systemd "systemctl";
      in {
        general = {
          after_sleep_cmd = mkIf isHyprland "${hyprctl} dispatch dpms on";
          before_sleep_cmd = "${loginctl} lock-session";
          lock_cmd = hyprlock;
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "${loginctl} lock-session";
          }
          (mkIf isHyprland
            {
              timeout = 330;
              on-timeout = "${hyprctl} dispatch dpms off";
              on-resume = "${hyprctl} dispatch dpms on";
            })
          {
            timeout = 600;
            on-timeout = "${systemctl} suspend";
          }
        ];
      };
    };

    desktop.hyprland.binds = let
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
    in [
      "SUPER, U, exec, ${toggleHypridle}"
    ];
  }
