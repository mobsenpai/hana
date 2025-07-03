{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
lib.mkIf osConfig.modules.system.desktop.enable
{
  home.packages = [pkgs.xdg-utils];
  xdg.portal.xdgOpenUsePortal = true;

  xdg.userDirs = let
    home = config.home.homeDirectory;
  in {
    enable = true;
    createDirectories = true;

    extraConfig = {
      XDG_SCREENSHOTS_DIR = "${home}/Pictures/Screenshots";
    };
  };

  xdg.mimeApps.enable = osConfig.modules.system.desktop.desktopEnvironment == null;

  desktop = {
    niri.settings.window-rules = [
      {
        matches = [{app-id = "xdg-desktop-portal-gtk";}];
        open-floating = true;
        default-column-width = {proportion = 0.6;};
        default-window-height = {proportion = 0.6;};
      }
    ];

    hyprland.settings.windowrule = [
      # Float the file picker
      "float, class:^(xdg-desktop-portal-gtk)$"
      "size 50% 50%, class:^(xdg-desktop-portal-gtk)$"
      "center, class:^(xdg-desktop-portal-gtk)$"
    ];
  };
}
