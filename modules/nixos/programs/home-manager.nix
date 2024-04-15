{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.home-manager.enable = lib.mkEnableOption "enables home-manager";
  };

  config = lib.mkIf config.mynixos.home-manager.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      verbose = true;
    };
  };
}
