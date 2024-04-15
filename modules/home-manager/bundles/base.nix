{
  config,
  lib,
  ...
}: {
  options = {
    myhome.base.enable = lib.mkEnableOption "enables base";
  };

  config = lib.mkIf config.myhome.base.enable {
    myhome = {
      # Config
      gtk.enable = lib.mkDefault true;
      home.enable = lib.mkDefault true;
      home-cursor.enable = lib.mkDefault true;

      # Programs
      bash.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      utils.enable = lib.mkDefault true;
    };
  };
}
