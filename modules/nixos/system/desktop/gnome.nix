{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkForce;
  cfg = config.modules.system.desktop;
in {
  config = mkIf (cfg.enable && cfg.desktopEnvironment == "gnome") {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # Only enable the power management feature on laptops
    services.upower.enable = mkForce (config.device.type == "laptop");
    services.power-profiles-daemon.enable = mkForce (config.device.type == "laptop");
  };
}
