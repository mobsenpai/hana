{
  config,
  lib,
  ...
}: {
  imports = [
    ./keys.nix
    ./options.nix
  ];

  options = {
    myhome.hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.myhome.hyprland.enable {
    myhome = {
      hyprland.options.enable = lib.mkDefault true;
      hyprland.keys.enable = lib.mkDefault true;
      clipboard.enable = lib.mkDefault true;
      hypridle.enable = lib.mkDefault true;
      hyprpaper.enable = lib.mkDefault true;
      hyprlock.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault true;
      wofi.enable = lib.mkDefault true;
    };
  };
}
