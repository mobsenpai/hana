{
  lib,
  config,
  ...
}: let
  cfg = config.modules.services.wlsunset;
in
  lib.mkIf cfg.enable
  {
    services.wlsunset = {
      enable = true;
      temperature.day = 6500;
      temperature.night = 5000;
      sunrise = "06:30";
      sunset = "21:00";
    };
  }
