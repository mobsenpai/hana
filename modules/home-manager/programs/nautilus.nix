{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe;
  cfg = config.modules.programs.nautilus;
in
  mkIf cfg.enable
  {
    home.packages = with pkgs; [
      nautilus
    ];

    dconf.settings."org/gnome/nautilus/preferences".default-folder-viewer = "list-view";

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
    };

    desktop = let
      nautilus = getExe pkgs.nautilus;
    in {
      niri.binds = {
        "Mod+F3" = {
          action.spawn = nautilus;
          hotkey-overlay.title = "Open nautilus file manager";
        };
      };

      hyprland.binds = [
        "SUPER, F3, Open nautilus file manager, exec, ${nautilus}"
      ];
    };
  }
