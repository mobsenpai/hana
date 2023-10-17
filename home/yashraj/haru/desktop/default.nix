{
  inputs,
  pkgs,
  config,
  ...
}: let
  inherit (config) colorscheme;
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in {
  imports = [
    ./rofi.nix
  ];

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
        else "Gruvbox-Plus-Dark"
      }";
      package = pkgs.gruvbox-plus-icon-pack;
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

  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "vivaldi";
    QT_QPA_PLATFORM = "wayland";
  };
}