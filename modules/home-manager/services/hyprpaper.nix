{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.hyprpaper.enable = lib.mkEnableOption "Enables hyprpaper";
  };

  config = lib.mkIf config.myhome.hyprpaper.enable {
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ${config.myhome.wallpaper}
      wallpaper = , ${config.myhome.wallpaper}
    '';

    systemd.user.services.hyprpaper = {
      Unit = {
        Description = "Hyprland wallpaper daemon";
        PartOf = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
        Restart = "on-failure";
      };

      Install.WantedBy = ["graphical-session.target"];
    };
  };
}
