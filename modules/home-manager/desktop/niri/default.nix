{
  lib,
  pkgs,
  inputs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf mkForce mkDefault getExe utils mkAliasOptionModule;
  inherit (config.modules.desktop) windowManager;
  osDesktop = osConfig.modules.system.desktop;
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

  config = {
    # TODO: a better way to do this?
    programs.niri = {
      package = mkDefault pkgs.niri;
      settings.xwayland-satellite.path = mkDefault (getExe pkgs.xwayland-satellite);
    };

    xdg.portal = mkIf (osDesktop.enable && windowManager == "Niri") {
      enable = mkForce true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };

    services.polkit-gnome.enable = mkIf (osDesktop.enable && windowManager == "Niri") true;
  };
}
