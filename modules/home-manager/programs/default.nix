{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  imports = lib.utils.scanPaths ./.;

  options.modules.programs = {
    alacritty.enable = mkEnableOption "alacritty";
    appflowy.enable = mkEnableOption "appflowy";
    fastfetch.enable = mkEnableOption "fastfetch";
    firefox.enable = mkEnableOption "firefox";
    git.enable = mkEnableOption "git";
    helix.enable = mkEnableOption "helix";
    hyprlock.enable = mkEnableOption "hyprlock";
    media.enable = mkEnableOption "media tools";
    ncspot.enable = mkEnableOption "ncspot";
    pcmanfm.enable = mkEnableOption "pcmanfm";
    tofi.enable = mkEnableOption "tofi";
    waybar.enable = mkEnableOption "waybar";
    wofi.enable = mkEnableOption "wofi";
    zathura.enable = mkEnableOption "zathura";
  };
}
