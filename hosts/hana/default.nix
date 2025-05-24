{
  imports = [./hardware-configuration.nix];

  modules = {
    core = {
      homeManager.enable = true;
    };

    programs = {
      dconf.enable = true;
    };

    services = {
      greetd.enable = true;
    };

    system = {
      device.type = "laptop";
      desktop.enable = true;

      audio.enable = true;
      bluetooth.enable = true;
    };
  };
}
