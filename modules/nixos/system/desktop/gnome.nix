{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.modules.system.desktop;
in {
  config = mkIf (cfg.enable && cfg.desktopEnvironment == "gnome") {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
