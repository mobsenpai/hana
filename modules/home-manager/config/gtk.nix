{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.gtk.enable = lib.mkEnableOption "enables gtk";
  };

  config = lib.mkIf config.myhome.gtk.enable {
    gtk = {
      enable = true;

      font = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };

      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
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
  };
}
