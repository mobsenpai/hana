{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) utils mkIf mkForce getExe;
  inherit (config.modules.system.desktop) desktopEnvironment;
  inherit (config.modules.core) homeManager;
  inherit (config.programs) uwsm;
  cfg = config.modules.system.bluetooth;
in
  mkIf cfg.enable
  {
    assertions = utils.asserts [
      (cfg.applet.enable -> config.modules.core.homeManager.enable)
      "bluetooth.applet requires homeManager.enable"

      (cfg.applet.enable -> desktopEnvironment == null)
      "bluetooth.applet only for window managers"
    ];

    hardware.bluetooth.enable = true;
    services.blueman.enable = desktopEnvironment == null;
    hm = let
      bash = getExe pkgs.bash;
    in
      mkIf homeManager.enable {
        services.blueman-applet.enable = cfg.applet.enable && desktopEnvironment == null;
        systemd.user.services.blueman-applet = mkIf (cfg.applet.enable && desktopEnvironment == null) {
          Unit = {
            Requires = mkIf uwsm.enable (mkForce []);
            After = mkForce ["graphical-session.target"];
            Wants = mkForce ["graphical-session.target"];
            PartOf = mkForce ["graphical-session.target"];
          };

          Service = {
            Type = "simple";
            RemainAfterExit = true;
            ExecStartPre = "${bash} -c 'while ! busctl --user list | grep -q org.kde.StatusNotifierWatcher; do sleep 0.5; done'";
            Slice = "app${utils.sliceSuffix config}.slice";
          };
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
