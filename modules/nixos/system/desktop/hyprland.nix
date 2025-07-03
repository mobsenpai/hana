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
  homeDesktopCfg = homeConfig.modules.desktop;
  hyprlandPackage = homeConfig.wayland.windowManager.hyprland.package;
  windowManager =
    if homeManager.enable
    then homeDesktopCfg.windowManager
    else null;
in {
  config = mkIf (cfg.enable && windowManager == "Hyprland") {
    assertions = utils.asserts [
      homeManager.enable
      "Hyprland requires Home Manager to be enabled"
    ];

    programs.hyprland = {
      enable = true;
      package = hyprlandPackage;
    };
    xdg.portal.enable = mkForce false;
    modules.services.greetd.sessionDirs = [
      "${hyprlandPackage}/share/wayland-sessions"
    ];
  };
}
