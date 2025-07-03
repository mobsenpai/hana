{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf getExe;
  cfg = config.modules.programs.appflowy;
in
  mkIf cfg.enable
  {
    home.packages = with pkgs; [
      appflowy
    ];

    desktop = let
      appflowy = getExe pkgs.appflowy;
    in {
      niri.binds = {
        "Mod+F4" = {
          action.spawn = appflowy;
          hotkey-overlay.title = "Open appflowy";
        };
      };

      hyprland.binds = [
        "SUPER, F4, exec, ${appflowy}"
      ];
    };
  }
