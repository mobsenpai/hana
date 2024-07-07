{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkIf mkForce mkMerge;
  inherit (config.modules.core) homeManager;
  inherit (homeConfig.programs) hyprlock;
  cfg = config.modules.system.desktop;
  homeConfig = config.home-manager.users.${username};
  homeDesktopCfg = homeConfig.modules.desktop;
  hyprlandPackage = homeConfig.wayland.windowManager.hyprland.package;
  windowManager =
    if homeManager.enable
    then homeDesktopCfg.windowManager
    else null;
in
  mkIf cfg.enable
  (mkMerge [
    {
      # Enables wayland for all apps that support it
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    }

    (mkIf homeManager.enable {
      xdg.portal.enable = mkForce false;
      security.pam.services.hyprlock = mkIf (hyprlock.enable) {};
    })

    (mkIf (cfg.desktopEnvironment == "gnome") {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };

      # Only enable the power management feature on laptops
      services.upower.enable = mkForce (config.device.type == "laptop");
      services.power-profiles-daemon.enable = mkForce (config.device.type == "laptop");
    })

    (mkIf (windowManager == "Hyprland") {
      programs.hyprland = {
        enable = true;
        package = hyprlandPackage;
      };
    })
  ])
