{
  config,
  lib,
  pkgs,
  ...
}: let
  cssContent = with config.myhome.colorscheme; ''
    @define-color accent_color ${xcolors.orange1};
    @define-color accent_bg_color ${xcolors.orange0};
    @define-color accent_fg_color ${xcolors.fg1};

    @define-color destructive_color ${xcolors.aqua1};
    @define-color destructive_bg_color ${xcolors.aqua0};
    @define-color destructive_fg_color ${xcolors.fg1};

    @define-color success_color ${xcolors.green1};
    @define-color success_bg_color ${xcolors.green0};
    @define-color success_fg_color ${xcolors.fg1};

    @define-color warning_color ${xcolors.yellow1};
    @define-color warning_bg_color ${xcolors.yellow0};
    @define-color warning_fg_color ${xcolors.fg1};

    @define-color error_color ${xcolors.red1};
    @define-color error_bg_color ${xcolors.red0};
    @define-color error_fg_color ${xcolors.fg1};

    @define-color window_bg_color ${xcolors.bg0};
    @define-color window_fg_color ${xcolors.fg1};

    @define-color view_bg_color ${xcolors.bg0};
    @define-color view_fg_color ${xcolors.fg1};

    @define-color headerbar_bg_color ${xcolors.bg0};
    @define-color headerbar_fg_color ${xcolors.fg1};
    @define-color headerbar_border_color ${xcolors.fg1};
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);

    @define-color card_bg_color rgba(255, 255, 255, 0.08);
    @define-color card_fg_color ${xcolors.fg1};
    @define-color card_shade_color rgba(0, 0, 0, 0.36);

    @define-color dialog_bg_color ${xcolors.bg1};
    @define-color dialog_fg_color ${xcolors.fg1};

    @define-color popover_bg_color ${xcolors.bg1};
    @define-color popover_fg_color ${xcolors.fg1};

    @define-color shade_color rgba(0, 0, 0, 0.36);
    @define-color scrollbar_outline_color rgba(0, 0, 0, 0.5);
  '';
in {
  options = {
    myhome.gtk.enable = lib.mkEnableOption "Enables gtk";
  };

  config = lib.mkIf config.myhome.gtk.enable {
    gtk = {
      enable = true;

      font = {
        package = pkgs.nerdfonts.override {fonts = ["FiraMono"];};
        name = "FiraMono Nerd Font";
        size = 10;
      };

      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
      };

      gtk3.extraCss = cssContent;
      gtk4.extraCss = cssContent;
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
    };
  };
}
