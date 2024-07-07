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

    desktop.hyprland.binds = let
      appflowy = getExe pkgs.appflowy;
    in [
      "SUPER, F3, exec, ${appflowy}"
    ];
  }
