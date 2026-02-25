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

    desktop = let
      pcmanfm = getExe pkgs.pcmanfm;
    in {
      niri.binds = {
        "Mod+F3" = {
          action.spawn = pcmanfm;
          hotkey-overlay.title = "Open pcmanfm file manager";
        };
      };

      hyprland.binds = [
        "SUPER, F3, Open pcmanfm file manager, exec, ${pcmanfm}"
      ];
    };
  }
