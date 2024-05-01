{
  config,
  lib,
  ...
}: {
  options = {
    myNixos.laptop.enable = lib.mkEnableOption "Enables Laptop";
  };

  config = lib.mkIf config.myNixos.bluetooth.enable {
    services = {
      logind = {
        powerKey = "suspend";
        lidSwitch = "suspend";
        lidSwitchExternalPower = "lock";
      };

      upower = {
        enable = true;
        percentageLow = 30;
        percentageCritical = 20;
        percentageAction = 10;
        criticalPowerAction = "Hibernate";
      };
    };
  };
}
