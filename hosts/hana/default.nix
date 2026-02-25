{
  imports = [./hardware-configuration.nix];

  modules = {
    core = {
      homeManager.enable = true;
    };

    programs = {
      gaming.enable = true;
      localsend.enable = true;
    };

    services = {
      greetd.enable = true;
    };

    system = {
      audio = {
        enable = true;
        inputNoiseSuppression = true;
      };

      bluetooth = {
        enable = true;
        applet.enable = true;
      };

      desktop = {
        enable = true;
        desktopEnvironment = null;
      };

      device = {
        battery = "BAT0";
        cpu = {
          type = "intel";
          threads = 16;
        };

        gpu.type = "nvidia";
        type = "laptop";
        monitors = [
          {
            number = 1;
            name = "eDP-1";
            width = 1920;
            height = 1200;
            scale = 1.20;
            refreshRate = 165.0;
            position.x = 0;
            position.y = 0;
            enabled = true;
            isPrimary = true;
          }

          {
            number = 2;
            name = "DP-1";
            width = 1366;
            height = 768;
            scale = 1.0;
            refreshRate = 60.0;
            position.x = 1600;
            position.y = 0;
            enabled = true;
          }
        ];
      };

      networking = {
        wireless.enable = true;
        applet.enable = true;
      };
    };
  };
}
