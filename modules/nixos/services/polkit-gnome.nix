{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.services.polkit-gnome;
in
  lib.mkIf cfg.enable
  {
    security.polkit.enable = true;

    # https://github.com/nix-community/home-manager/pull/5619
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  }
