{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mynixos.fontconfig.enable = lib.mkEnableOption "enables fontconfig";
  };

  config = lib.mkIf config.mynixos.fontconfig.enable {
    fonts = {
      enableDefaultPackages = false;

      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = ["Noto Color Emoji"];
          monospace = ["JetBrainsMono Nerd Font"];
          serif = ["Noto Serif"];
          sansSerif = ["Noto Sans"];
        };
      };
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        (nerdfonts.override {fonts = ["JetBrainsMono"];})
      ];
    };
  };
}
