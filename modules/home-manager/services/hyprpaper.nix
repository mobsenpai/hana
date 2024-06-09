{
  config,
  lib,
  ...
}: {
  options = {
    myHome.hyprpaper.enable = lib.mkEnableOption "Enables hyprpaper";
  };

  config = lib.mkIf config.myHome.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          config.myHome.wallpaper
        ];
        wallpaper = [
          ", ${config.myHome.wallpaper}"
        ];
      };
    };
  };
}
