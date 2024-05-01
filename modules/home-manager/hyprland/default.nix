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
    myHome.hyprland.enable = lib.mkEnableOption "Enable hyprland";
  };

  config = lib.mkIf config.myHome.hyprland.enable {
    myHome = {
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
