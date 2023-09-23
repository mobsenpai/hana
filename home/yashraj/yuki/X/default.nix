{config, ...}: let
  inherit (config.colorscheme) colors;
in {
  xresources.extraConfig = with colors; ''
    ! special
    *background: #${base00}
    *foreground: #${base05}

    ! black
    *color0: #${base00}
    *color8: #${base03}

    ! red
    *color1: #${base08}
    *color9: #${base08}

    ! green
    *color2: #${base0B}
    *color10: #${base0B}

    ! yellow
    *color3: #${base0A}
    *color11: #${base0A}

    ! blue
    *color4: #${base0D}
    *color12: #${base0D}

    ! magenta
    *color5: #${base0E}
    *color13: #${base0E}

    ! cyan
    *color6: #${base0C}
    *color14: #${base0C}

    ! white
    *color7: #${base05}
    *color15: #${base07}
  '';
}
