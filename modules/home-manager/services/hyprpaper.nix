{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myHome.hyprpaper.enable = lib.mkEnableOption "Enables hyprpaper";
  };

  config = lib.mkIf config.myHome.hyprpaper.enable {
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ${config.myHome.wallpaper}
      wallpaper = , ${config.myHome.wallpaper}
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
