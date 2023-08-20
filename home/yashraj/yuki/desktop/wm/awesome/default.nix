{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.colorscheme) colors;
  theme = "gruva";
in {
  xresources.extraConfig = ''
    Xft.antialias: true
    Xft.hinting: true
    Xft.rgba: rgb
    Xft.autohint: false
    Xft.hintstyle: hintfull
    Xft.lcdfilter: lcddefault

    *.cursorColor:  #${colors.base05}
    *background: #${colors.base00}
    *foreground: #${colors.base07}

    ! black
    *color0: #${colors.base00}
    *color8: #${colors.base03}

    ! red
    *color1: #${colors.base08D}
    *color9: #${colors.base08}

    ! green
    *color2: #${colors.base0BD}
    *color10: #${colors.base0B}

    ! yellow
    *color3: #${colors.base0AD}
    *color11: #${colors.base0A}

    ! blue
    *color4: #${colors.base0DD}
    *color12: #${colors.base0D}

    ! magenta
    *color5: #${colors.base0ED}
    *color13: #${colors.base0E}

    ! cyan
    *color6: #${colors.base0CD}
    *color14: #${colors.base0C}

    ! white
    *color7: #${colors.base06}
    *color15: #${colors.base07}
  '';

  home = {
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "vivaldi";
    };

    file = {
      # Setup
      ".config/awesome/configuration".source = ./. + "/${theme}";
      ".config/awesome/rc.lua".source = ./rc.lua;
      ".config/awesome/helpers.lua".source = ./helpers.lua;
      ".config/awesome/keys.lua".source = ./keys.lua;

      # Modules
      ".config/awesome/module/json.lua".source = ./module/json.lua;
      ".config/awesome/module/lockscreen".source = ./module/lockscreen;
      ".config/awesome/module/window_switcher.lua".source = ./module/window_switcher.lua;
    };
  };

  imports = [
    ../../gtk.nix
    ../../picom.nix
    ../../rofi.nix
    ../../flameshot.nix
    ../../clipmenu.nix
    ../../nm-applet.nix
  ];
}
