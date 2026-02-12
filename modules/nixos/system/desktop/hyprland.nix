{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkIf mkForce utils;
  inherit (config.modules.core) homeManager;
  cfg = config.modules.system.desktop;
  homeConfig = config.home-manager.users.${username};
  homeDesktop = homeConfig.modules.desktop;
  windowManager =
    if (homeManager.enable or false)
    then homeDesktop.windowManager
    else null;
in {
  config = mkIf (cfg.enable && windowManager == "Hyprland") {
    assertions = utils.asserts [
      (homeManager.enable or false)
      "Hyprland requires Home Manager to be enabled"
    ];

    programs.hyprland = {
      enable = true;
    };

    xdg.portal.enable = mkForce false;
  };
}
