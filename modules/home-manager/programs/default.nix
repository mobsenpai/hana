{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = lib.utils.scanPaths ./.;

  options.modules.programs = {
    alacritty.enable = mkEnableOption "alacritty";
    appflowy.enable = mkEnableOption "appflowy";
    fastfetch.enable = mkEnableOption "fastfetch";
    git.enable = mkEnableOption "git";
    helix.enable = mkEnableOption "helix";
    hyprlock.enable = mkEnableOption "hyprlock";
    media.enable = mkEnableOption "media tools";
    firefox.enable = mkEnableOption "firefox";
    waybar.enable = mkEnableOption "waybar";
    wofi.enable = mkEnableOption "wofi";
  };
}
