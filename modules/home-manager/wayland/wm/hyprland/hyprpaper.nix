{
  pkgs,
  themes,
  ...
}: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${themes.wallpaper}
    wallpaper = , ${themes.wallpaper}
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
}
