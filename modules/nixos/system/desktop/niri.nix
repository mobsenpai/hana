{
  lib,
  pkgs,
  inputs,
  config,
  username,
  ...
}: let
  inherit (lib) mkIf utils;
  inherit (config.modules.core) homeManager;
  cfg = config.modules.system.desktop;
  homeConfig = config.home-manager.users.${username};
  homeDesktopCfg = homeConfig.modules.desktop;
  niriPackage = inputs.niri.packages.${pkgs.system}.niri-stable;
  windowManager =
    if homeManager.enable
    then homeDesktopCfg.windowManager
    else null;
in {
  config = mkIf (cfg.enable && windowManager == "Niri") {
    assertions = utils.asserts [
      homeManager.enable
      "Niri requires Home Manager to be enabled"
    ];

    programs.niri = {
      enable = true;
      package = niriPackage;
    };

    modules.services.greetd.sessionDirs = [
      "${niriPackage}/share/wayland-sessions"
    ];
  };
}
