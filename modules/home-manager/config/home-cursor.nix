{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.home-cursor.enable = lib.mkEnableOption "Enables home-cursor";
  };

  config = lib.mkIf config.myhome.home-cursor.enable {
    home.pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
      gtk.enable = true;
    };
  };
}
