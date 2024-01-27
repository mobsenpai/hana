{
  inputs,
  config,
  pkgs,
  ...
}: let
  inherit (config) colorscheme;
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in {
  home.pointerCursor = {
    name = "${
      if config.colorscheme.kind == "light"
      then "Yaru"
      else "Yaru"
    }";
    package = pkgs.yaru-theme;
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = colorscheme.slug;
      package = gtkThemeFromScheme {
        scheme = colorscheme;
      };
    };

    iconTheme = {
      name = "${
        if colorscheme.kind == "light"
        then "Adwaita"
        else "Yaru-dark"
      }";
      package = pkgs.yaru-theme;
    };

    font = {
      name = "monospace";
      size = 10;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.qt6Packages.qt6gtk2;
    };
  };
}
