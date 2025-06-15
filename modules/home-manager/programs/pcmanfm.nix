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

    desktop.hyprland.settings.windowrule = [
      "float, class:^(pcmanfm)$"
      "size 50% 50%, class:^(pcmanfm)$"
      "center, class:^(pcmanfm)$"
    ];

    desktop.hyprland.binds = let
      pcmanfm = getExe pkgs.pcmanfm;
    in [
      "SUPER, F3, exec, ${pcmanfm}"
    ];
  }
