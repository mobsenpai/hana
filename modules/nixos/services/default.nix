{lib, ...}: let
  inherit (lib) utils mkEnableOption mkOption types concatStringsSep;
in {
  imports = utils.scanPaths ./.;

  options.modules.services = {
    greetd = {
      enable = mkEnableOption "greetd with tuigreet";
      sessionDirs = mkOption {
        type = with types; listOf str;
        apply = concatStringsSep ":";
        default = [];
        description = "Directories that contain .desktop files to be used as session definitions";
      };
    };
  };

  config = {
    services = {
      gvfs.enable = true;
    };
  };
}
