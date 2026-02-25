{
  lib,
  config,
  ...
}: let
  inherit (lib) utils mkIf;
  inherit (config.modules.system.desktop) desktopEnvironment;
  inherit (config.modules.core) homeManager;
  cfg = config.modules.system.bluetooth;
in
  lib.mkIf cfg.enable
  {
    assertions = utils.asserts [
      (cfg.applet.enable -> config.modules.core.homeManager.enable)
      "bluetooth.applet requires homeManager.enable"

      (cfg.applet.enable -> desktopEnvironment == null)
      "bluetooth.applet only for window managers"
    ];

    hardware.bluetooth.enable = true;
    services.blueman.enable = mkIf (desktopEnvironment == null) true;
    hm = mkIf homeManager.enable {
      services = mkIf (cfg.applet.enable && desktopEnvironment == null) {
        blueman-applet.enable = true;
      };

      desktop.niri.settings.window-rules = [
        {
          matches = [{app-id = "\\.blueman-manager-wrapped";}];
          open-floating = true;
          default-column-width = {proportion = 0.6;};
          default-window-height = {proportion = 0.6;};
        }
      ];

      desktop.hyprland.settings.windowrule = [
        "float, class:^(\\.blueman-manager-wrapped)$"
        "size 60% 60%, class:^(\\.blueman-manager-wrapped)$"
        "center, class:^(\\.blueman-manager-wrapped)$"
      ];
    };
  }
