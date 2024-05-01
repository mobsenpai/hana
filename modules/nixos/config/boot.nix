{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.boot.enable = lib.mkEnableOption "Enables boot";
  };

  config = lib.mkIf config.myNixos.boot.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };
  };
}
