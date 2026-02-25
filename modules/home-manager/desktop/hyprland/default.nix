{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf mkForce utils mkAliasOptionModule;
  inherit (config.modules.desktop) windowManager;
  osDesktop = osConfig.modules.system.desktop;
  hyprland = config.wayland.windowManager.hyprland.package;
in {
  imports =
    utils.scanPaths ./.
    ++ [
      (mkAliasOptionModule
        ["desktop" "hyprland" "binds"]
        ["wayland" "windowManager" "hyprland" "settings" "bindd"])

      (mkAliasOptionModule
        ["desktop" "hyprland" "settings"]
        ["wayland" "windowManager" "hyprland" "settings"])
    ];

  config = mkIf (osDesktop.enable && windowManager == "Hyprland") {
    assertions = utils.asserts [
      (!osConfig.xdg.portal.enable)
      "Hyprland's portal configuration conflicts with existing xdg.portal settings"
    ];

    xdg.portal = {
      enable = mkForce true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      configPackages = [hyprland];
    };

    services.hyprpolkitagent.enable = true;
  };
}
