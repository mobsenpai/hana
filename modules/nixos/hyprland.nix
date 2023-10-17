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
        brightnessctl
        wl-clipboard
        grim
        slurp
        swappy
        dunst
        gtklock
        waybar
        swayosd
        imv
        ;
    };

    programs = {
      xwayland.enable = false;
    };
  };
}
