{
  config,
  lib,
  ...
}: {
  options = {
    myhome.wofi.enable = lib.mkEnableOption "enables wofi";
  };

  config = lib.mkIf config.myhome.wofi.enable {
    programs.wofi = {
      enable = true;
    };
  };
}
