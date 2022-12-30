{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  gtk = {
    enable = true;
    # theme = {
    #   name = "gruvbox-dark";
    #   package = pkgs.gruvbox-dark-gtk;
    # };

    theme = {
      name = "phocus";
      package = pkgs.phocus.override {
        colors = with colors; {
          base00 = "${base00}";
          base01 = "${base01}";
          base02 = "${base02}";
          base03 = "${base03}";
          base04 = "${base04}";
          base05 = "${base05}";
          base06 = "${base06}";
          base07 = "${base07}";
          base08 = "${base08}";
          base09 = "${base09}";
          base0A = "${base0A}";
          base0B = "${base0B}";
          base0C = "${base0C}";
          base0D = "${base0D}";
          base0E = "${base0E}";
          base0F = "${base0F}";
        };

        primary = "${colors.base02}";
        secondary = "${colors.base04}";
      };
    };

    # iconTheme = {
    #   name = "oomox-gruvbox-dark";
    #   package = pkgs.gruvbox-dark-icons-gtk;
    # };

    font = {
      name = "JetBrainsMono Nerd Font Regular";
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

  qt = {
    enable = true;
    platformTheme = "gtk";
    # style = {
    #   package = pkgs.adwaita-qt;
    #   name = "adwaita-dark";
    # };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  home.sessionVariables = {
    # Theming Related Variables
    GTK_THEME = "gruvbox-dark";
    XCURSOR_SIZE = "24";
  };
}
