{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.networking.enable = lib.mkEnableOption "enables networking";
  };

  config = lib.mkIf config.mynixos.networking.enable {
    networking = {
      networkmanager = {
        enable = true;
      };

      useDHCP = false;
    };
  };
}
