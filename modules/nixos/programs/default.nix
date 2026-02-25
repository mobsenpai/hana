{lib, ...}: let
  inherit (lib) utils mkEnableOption;
in {
  imports = utils.scanPaths ./.;

  options.modules.programs = {
    gaming.enable = mkEnableOption "gaming";
    localsend.enable = mkEnableOption "localsend";
  };
}
