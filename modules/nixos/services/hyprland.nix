{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mynixos.hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.mynixos.hyprland.enable {
    environment = {
      variables = {
        QT_QPA_PLATFORM = "wayland;xcb";
      };
    };

    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };

    security = {
      pam.services = {
        hyprlock.text = "auth include login";
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
}
