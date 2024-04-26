{
  config,
  lib,
  pkgs,
  ...
}: let
  cssContent = with config.myhome.colorscheme; ''
    @define-color accent_color ${xcolors.orange};
    @define-color accent_bg_color ${xcolors.dark-orange};
    @define-color accent_fg_color ${xcolors.white};

    @define-color destructive_color ${xcolors.aqua};
    @define-color destructive_bg_color ${xcolors.dark-aqua};
    @define-color destructive_fg_color ${xcolors.white};

    @define-color success_color ${xcolors.green};
    @define-color success_bg_color ${xcolors.dark-green};
    @define-color success_fg_color ${xcolors.white};

    @define-color warning_color ${xcolors.yellow};
    @define-color warning_bg_color ${xcolors.dark-yellow};
    @define-color warning_fg_color ${xcolors.white};

    @define-color error_color ${xcolors.red};
    @define-color error_bg_color ${xcolors.dark-red};
    @define-color error_fg_color ${xcolors.white};

    @define-color window_bg_color ${xcolors.black};
    @define-color window_fg_color ${xcolors.white};

    @define-color view_bg_color ${xcolors.black};
    @define-color view_fg_color ${xcolors.white};

    @define-color headerbar_bg_color ${xcolors.black};
    @define-color headerbar_fg_color ${xcolors.white};
    @define-color headerbar_border_color ${xcolors.white};
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);

    @define-color card_bg_color rgba(255, 255, 255, 0.08);
    @define-color card_fg_color ${xcolors.white};
    @define-color card_shade_color rgba(0, 0, 0, 0.36);

    @define-color dialog_bg_color ${xcolors.soft-black};
    @define-color dialog_fg_color ${xcolors.white};

    @define-color popover_bg_color ${xcolors.soft-black};
    @define-color popover_fg_color ${xcolors.white};

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
        name = "Fira Mono Nerd Font";
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
