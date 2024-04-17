{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.gnome-keyring.enable = lib.mkEnableOption "enables gnome-keyring";
  };

  config = lib.mkIf config.mynixos.gnome-keyring.enable {
    services = {
      gnome.gnome-keyring.enable = true;
    };
  };
}
