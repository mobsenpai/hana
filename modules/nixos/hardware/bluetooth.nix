{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.bluetooth.enable = lib.mkEnableOption "Enables bluetooth";
  };

  config = lib.mkIf config.myNixos.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
    };

    services.blueman.enable = true;
  };
}
