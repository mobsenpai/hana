{
  inputs,
  pkgs,
  config,
  ...
}: let
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in {
  imports = [
    ./rofi.nix
  ];

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
        else "gruvbox-plus"
      }";
      package = pkgs.gruvbox-icons;
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

  qt.enable = true;

  home = {
    pointerCursor = {
      name = "${
        if config.colorscheme.kind == "light"
        then "phinger-cursors"
        else "phinger-cursors-light"
      }";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      # Theming Related Variables
      GTK_THEME = "${config.colorscheme.slug}";
      XCURSOR_SIZE = "${builtins.toString config.home.pointerCursor.size}";
    };
  };
}
