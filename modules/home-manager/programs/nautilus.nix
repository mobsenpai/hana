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
      app2unit = getExe pkgs.app2unit;
    in {
      niri.binds = with config.lib.niri.actions; {
        "Mod+F3" = {
          action = spawn app2unit "-t" "service" "--" "org.gnome.Nautilus.desktop";
          hotkey-overlay.title = "Open nautilus file manager";
        };
      };

      hyprland.binds = [
        "SUPER, F3, Open nautilus file manager, exec, ${app2unit} -t service org.gnome.Nautilus.desktop"
      ];
    };
  }
