{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe;
  cfg = config.modules.programs.pcmanfm;
in
  mkIf cfg.enable
  {
    home.packages = with pkgs; [
      pcmanfm
    ];

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["pcmanfm.desktop"];
    };

    desktop.hyprland.settings.windowrulev2 = [
      "float, class:^(org.gnome.pcmanfm)$"
      "size 50% 50%, class:^(org.gnome.pcmanfm)$"
      "center, class:^(org.gnome.pcmanfm)$"
    ];

    desktop.hyprland.binds = let
      pcmanfm = getExe pkgs.pcmanfm;
    in [
      "SUPER, F3, exec, ${pcmanfm}"
    ];
  }
