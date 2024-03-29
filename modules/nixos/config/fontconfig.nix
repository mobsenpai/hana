{
  lib,
  pkgs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts
      noto-fonts-cjk
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };
      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font"];
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
      };
    };
  };
}
