{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = lib.utils.scanPaths ./.;

  options.modules.services = {
    cliphist.enable = mkEnableOption "cliphist daemon";
    hypridle.enable = mkEnableOption "hypridle daemon";
    hyprpaper.enable = mkEnableOption "hyprpaper daemon";
    swaync.enable = mkEnableOption "swaync notification daemon";
  };
}
