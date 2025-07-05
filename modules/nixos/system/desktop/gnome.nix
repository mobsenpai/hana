# TODO:
# 1. try a desktopenvironment to test the conditions
# for example how does hyprpaper play out if left enabled
# 2. greetd assertion, do we need more?
# 3. more assertions check, like how hypridle asserts hyprlock not enabled
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
