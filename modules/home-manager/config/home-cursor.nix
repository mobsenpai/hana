{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myHome.home-cursor.enable = lib.mkEnableOption "Enables home-cursor";
  };

  config = lib.mkIf config.myHome.home-cursor.enable {
    home.pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
      gtk.enable = true;
    };
  };
}
