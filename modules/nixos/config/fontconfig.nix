{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mynixos.fontconfig.enable = lib.mkEnableOption "Enables fontconfig";
  };

  config = lib.mkIf config.mynixos.fontconfig.enable {
    fonts = {
      enableDefaultPackages = false;

      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = ["Noto Color Emoji"];
          monospace = ["FiraMono Nerd Font"];
          serif = ["Noto Serif"];
          sansSerif = ["Noto Sans"];
        };
      };
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        (nerdfonts.override {fonts = ["FiraMono"];})
      ];
    };
  };
}
