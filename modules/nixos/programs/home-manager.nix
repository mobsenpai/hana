{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.home-manager.enable = lib.mkEnableOption "Enables home-manager";
  };

  config = lib.mkIf config.myNixos.home-manager.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      verbose = true;
    };
  };
}
