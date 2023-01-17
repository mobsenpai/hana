{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  xresources.extraConfig = ''
    Xft.antialias: true
    Xft.hinting: true
    Xft.rgba: rgb
    Xft.autohint: false
    Xft.hintstyle: hintfull
    Xft.lcdfilter: lcddefault
    *foreground: #${colors.base0F}
    *background: #${colors.base00}
    *.cursorColor:  #${colors.base05}
    ! black
    *color0: #${colors.base00}
    *color8: #${colors.base08}
    ! red
    *color1: #${colors.base09D}
    *color9: #${colors.base09}
    ! green
    *color2: #${colors.base0AD}
    *color10: #${colors.base0A}
    ! yellow
    *color3: #${colors.base0BD}
    *color11: #${colors.base0B}
    ! blue
    *color4: #${colors.base0CD}
    *color12: #${colors.base0C}
    ! magenta
    *color5: #${colors.base0DD}
    *color13: #${colors.base0D}
    ! cyan
    *color6: #${colors.base0ED}
    *color14: #${colors.base0E}
    ! white
    *color7: #${colors.base07}
    *color15: #${colors.base0F}
  '';

  home = {
    packages = with pkgs; [
      feh
      volumeicon
    ];

    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };

    file = {
      # ".config/awesome/rc.lua".source = ./rc.lua;
      # ".config/awesome/themes".source = ./themes;
      ".config/awesome/lain".source = inputs.lain.outPath;
      # ".config/awesome/modules/bling".source = inputs.bling.outPath;
      # ".config/awesome/modules/freedesktop".source = inputs.freedesktop.outPath;
    };
  };

  imports = [
    ../../gtk.nix
    ../../picom.nix
    # ../../rofi.nix
  ];
}
