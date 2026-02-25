{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkForce;
  cfg = config.modules.system.desktop;
in {
  config = mkIf (cfg.enable && cfg.desktopEnvironment == "gnome") {
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;

    # Gnome uses network manager
    modules.system.networking.useNetworkd = mkForce false;
  };
}
