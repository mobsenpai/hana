{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.gnome-keyring.enable = lib.mkEnableOption "Enables gnome-keyring";
  };

  config = lib.mkIf config.myNixos.gnome-keyring.enable {
    services = {
      gnome.gnome-keyring.enable = true;
    };
  };
}
