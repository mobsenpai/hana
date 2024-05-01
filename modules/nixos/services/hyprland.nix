{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myNixos.hyprland.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.myNixos.hyprland.enable {
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
      pam.services.hyprlock.text = "auth include login";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
}
