{lib, ...}: let
  inherit (lib) utils mkEnableOption;
in {
  imports = utils.scanPaths ./.;

  options.modules.programs = {};
}
