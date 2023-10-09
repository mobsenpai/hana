{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.hyprland;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = lib.attrValues {
      inherit
        (pkgs)
        waybar
        dunst
        ;
    };
  };
}
