{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.boot.enable = lib.mkEnableOption "enables boot";
  };

  config = lib.mkIf config.mynixos.boot.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };
  };
}
