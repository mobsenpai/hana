{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myNixos.mtp.enable = lib.mkEnableOption "Enables mtp";
  };

  config = lib.mkIf config.myNixos.mtp.enable {
    services = {
      gvfs.enable = true;
      tumbler.enable = true;
      udev.packages = with pkgs; [android-udev-rules];
    };
  };
}
