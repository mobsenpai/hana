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

    # Appflowy browser redirect
    # https://github.com/NixOS/nixpkgs/pull/338413

    desktop.hyprland.binds = let
      appflowy = getExe pkgs.appflowy;
    in [
      "SUPER, F3, exec, ${appflowy}"
    ];
  }
