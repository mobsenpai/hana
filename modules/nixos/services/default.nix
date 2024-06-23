{lib, ...}: let
  inherit (lib) utils mkEnableOption;
in {
  imports = utils.scanPaths ./.;

  options.modules.services = {
    gnome-keyring.enable = mkEnableOption "gnome keyring";
    polkit-gnome.enable = mkEnableOption "gnome polkit";
  };

  config = {
    services = {
      tumbler.enable = true;
      gvfs.enable = true;
    };
  };
}
