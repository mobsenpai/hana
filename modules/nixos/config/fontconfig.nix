{
  lib,
  pkgs,
  ...
}: {
  fonts = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        noto-fonts-emoji
        noto-fonts
        noto-fonts-cjk
        ;
      nerdfonts = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    };

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
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["JetBrainsMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
