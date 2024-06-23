{
  imports = [./hardware-configuration.nix];

  modules = {
    core = {
      homeManager.enable = true;
    };
    services = {
      gnome-keyring.enable = true;
      polkit-gnome.enable = true;
    };
    system = {
      device.type = "laptop";
      desktop.enable = true;

      audio.enable = true;
      bluetooth.enable = true;
    };
  };
}
