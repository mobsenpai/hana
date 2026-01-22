{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf utils;
  inherit (config.modules.system) desktop;
  inherit (config.modules.system) device;
in
  mkIf (device.type == "laptop") {
    assertions = utils.asserts [
      (desktop.enable or false)
      "Battery notification requires desktop to be enabled"
      (desktop.desktopEnvironment == null)
      "Do not enable when using a desktop environment as it brings its implementation"
    ];

    systemd.user.timers."low-battery-notify" = {
      timerConfig.OnBootSec = "2m";
      timerConfig.OnUnitInactiveSec = "2m";
      wantedBy = ["timers.target"];
    };

    systemd.user.services."low-battery-notify" = {
      requisite = ["graphical-session.target"];
      after = ["graphical-session.target"];
      path = lib.mkForce []; # inherit user session env vars
      script = ''
        cap=$(cat /sys/class/power_supply/${device.battery}/capacity)
        status=$(cat /sys/class/power_supply/${device.battery}/status)

        if [[ $cap -le 10 && $status == "Discharging" ]]; then
          ${lib.getExe pkgs.libnotify} --transient --urgency=critical -t 5000 "Battery Low" "$cap% remaining";
        fi
      '';
    };
  }
