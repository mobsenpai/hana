{
  lib,
  pkgs,
  inputs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf mkForce utils mkAliasOptionModule;
  inherit (config.modules.desktop) windowManager;
  osDesktopEnabled = osConfig.modules.system.desktop.enable;
in {
  imports =
    [inputs.niri.homeModules.niri]
    ++ utils.scanPaths ./.
    ++ [
      (mkAliasOptionModule
        ["desktop" "niri" "binds"]
        ["programs" "niri" "settings" "binds"])

      (mkAliasOptionModule
        ["desktop" "niri" "settings"]
        ["programs" "niri" "settings"])
    ];

  config = mkIf (osDesktopEnabled && windowManager == "Niri") {
    xdg.portal = {
      enable = mkForce true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };

    services.polkit-gnome.enable = true;
  };
}
