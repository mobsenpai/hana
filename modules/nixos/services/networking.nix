{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.networking.enable = lib.mkEnableOption "Enables networking";
  };

  config = lib.mkIf config.myNixos.networking.enable {
    networking = {
      networkmanager = {
        enable = true;
      };

      useDHCP = false;
    };
  };
}
