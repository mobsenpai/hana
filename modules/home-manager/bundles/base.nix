{
  config,
  lib,
  ...
}: {
  options = {
    myhome.base.enable = lib.mkEnableOption "Enables base";
  };

  config = lib.mkIf config.myhome.base.enable {
    myhome = {
      gtk.enable = lib.mkDefault true;
      home.enable = lib.mkDefault true;
      home-cursor.enable = lib.mkDefault true;

      bash.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      utils.enable = lib.mkDefault true;
    };
  };
}
