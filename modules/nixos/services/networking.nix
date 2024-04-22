{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.networking.enable = lib.mkEnableOption "Enables networking";
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
