{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.bluetooth.enable = lib.mkEnableOption "enables bluetooth";
  };

  config = lib.mkIf config.mynixos.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
    };

    services.blueman.enable = true;
  };
}
