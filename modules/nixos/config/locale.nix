{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.locale.enable = lib.mkEnableOption "Enables locale";
  };

  config = lib.mkIf config.myNixos.locale.enable {
    time = {
      hardwareClockInLocalTime = true;
      timeZone = "Asia/Kolkata";
    };
  };
}
