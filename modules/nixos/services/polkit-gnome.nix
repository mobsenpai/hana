{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mynixos.polkit-gnome.enable = lib.mkEnableOption "Enables polkit-gnome";
  };

  config = lib.mkIf config.mynixos.polkit-gnome.enable {
    security.polkit.enable = true;

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
  };
}
