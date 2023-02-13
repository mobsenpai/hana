{
  inputs,
  pkgs,
  config,
  ...
}: let
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in {
  gtk = {
    enable = true;
    theme = {
      name = "${config.colorscheme.slug}";
      package = gtkThemeFromScheme {
        scheme = config.colorscheme;
      };
    };

    iconTheme = {
      name = "${
        if config.colorscheme.kind == "light"
        then "Adwaita"
        else "Adwaita"
      }";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    font = {
      name = "monospace";
      size = 10;
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-decoration-layout = "menu:";
    };

    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  qt.enable = true;

  home.pointerCursor = {
    name = "${
      if config.colorscheme.kind == "light"
      then "phinger-cursors"
      else "phinger-cursors-light"
    }";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };

  home.sessionVariables = {
    # Theming Related Variables
    GTK_THEME = "${config.colorscheme.slug}";
    XCURSOR_SIZE = "${builtins.toString config.home.pointerCursor.size}";
  };
}
