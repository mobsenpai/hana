{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mynixos.mtp.enable = lib.mkEnableOption "Enables mtp";
  };

  config = lib.mkIf config.mynixos.mtp.enable {
    services = {
      gvfs.enable = true;
      tumbler.enable = true;
      udev.packages = with pkgs; [android-udev-rules];
    };
  };
}
