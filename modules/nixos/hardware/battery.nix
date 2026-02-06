{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf utils getExe mkForce;
  inherit (config.modules.system) desktop;
  inherit (config.modules.system) device;
in
  mkIf (device.type == "laptop") {
    assertions = utils.asserts [
      (desktop.enable or false)
      "hardware.battery requires desktop to be enabled"
      (desktop.desktopEnvironment == null)
      "Do not enable hardware.battery when using a desktop environment as it brings its implementation"
    ];

    systemd.user.timers."low-battery-notify" = {
      timerConfig.OnBootSec = "2m";
      timerConfig.OnUnitInactiveSec = "2m";
      wantedBy = ["timers.target"];
    };

    systemd.user.services."low-battery-notify" = let
      libnotify = getExe pkgs.libnotify;
    in {
      requisite = ["graphical-session.target"];
      after = ["graphical-session.target"];
      path = mkForce []; # inherit user session env vars
      script = ''
        cap=$(cat /sys/class/power_supply/${device.battery}/capacity)
        status=$(cat /sys/class/power_supply/${device.battery}/status)

        if [[ $cap -le 10 && $status == "Discharging" ]]; then
          ${libnotify} --transient --urgency=critical -t 5000 "Battery Low" "$cap% remaining";
        fi
      '';
    };
  }
# TODO: bad assertion, no way to enable or disable hardware.battery

