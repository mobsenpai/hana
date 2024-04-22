{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.locale.enable = lib.mkEnableOption "Enables locale";
  };

  config = lib.mkIf config.mynixos.locale.enable {
    time = {
      hardwareClockInLocalTime = true;
      timeZone = "Asia/Kolkata";
    };
  };
}
