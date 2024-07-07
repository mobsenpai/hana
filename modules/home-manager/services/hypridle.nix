{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe getExe';
  cfg = config.modules.services.hypridle;

  suspendScript = let
    pw-cli = getExe' pkgs.pipewire "pw-cli";
    grep = getExe pkgs.ripgrep;
    systemctl = getExe' pkgs.systemd "systemctl";
  in
    pkgs.writeShellScript "suspend-script" ''
      ${pw-cli} i all 2>&1 | ${grep} running -q
      # Only suspend if audio isn't running
      if [ $? == 1 ]; then
        ${systemctl} suspend
      fi
    '';
in
  mkIf cfg.enable
  {
    services.hypridle = {
      enable = true;
      settings = let
        pidof = getExe' pkgs.procps "pidof";
        loginctl = getExe' pkgs.systemd "loginctl";
        hyprlock = getExe pkgs.hyprlock;
      in {
        general = {
          before_sleep_cmd = "${loginctl} lock-session";
          lock_cmd = "${pidof} hyprlock || ${hyprlock}";
        };

        listener = [
          {
            timeout = 1800;
            on-timeout = suspendScript.outPath;
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
