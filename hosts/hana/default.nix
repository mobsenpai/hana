{
  imports = [./hardware-configuration.nix];

  modules = {
    core = {
      homeManager.enable = true;
    };

    programs = {
      gaming.enable = true;
    };

    services = {
      greetd.enable = true;
    };

    system = {
      device = {
        type = "laptop";
        gpu.type = "nvidia";
        battery = "BAT0";
      };

      desktop.enable = true;
      audio = {
        enable = true;
        inputNoiseSuppression = true;
      };
      bluetooth.enable = true;
    };
  };
}
