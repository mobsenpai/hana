{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (config.modules.colorScheme) xcolors polarity;
  cssContent = ''
    @define-color accent_color         ${xcolors.base16};
    @define-color accent_bg_color      ${xcolors.base0D};
    @define-color accent_fg_color      ${xcolors.base05};

    @define-color destructive_color    ${xcolors.base12};
    @define-color destructive_bg_color ${xcolors.base08};
    @define-color destructive_fg_color ${xcolors.base05};

    @define-color success_color        ${xcolors.base14};
    @define-color success_bg_color     ${xcolors.base0B};
    @define-color success_fg_color     ${xcolors.base05};

    @define-color warning_color        ${xcolors.base13};
    @define-color warning_bg_color     ${xcolors.base0A};
    @define-color warning_fg_color     ${xcolors.base05};

    @define-color error_color          ${xcolors.base12};
    @define-color error_bg_color       ${xcolors.base08};
    @define-color error_fg_color       ${xcolors.base05};

    @define-color window_bg_color      ${xcolors.base00};
    @define-color window_fg_color      ${xcolors.base05};

    @define-color view_bg_color        ${xcolors.base01};
    @define-color view_fg_color        ${xcolors.base05};

    @define-color headerbar_bg_color   ${xcolors.base01};
    @define-color headerbar_fg_color   ${xcolors.base05};
    @define-color headerbar_border_color @headerbar_fg_color;
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);

    @define-color sidebar_bg_color     ${xcolors.base02};
    @define-color sidebar_fg_color     ${xcolors.base05};
    @define-color sidebar_backdrop_color ${xcolors.base01};
    @define-color sidebar_border_color rgba(0, 0, 0, 0.36);
    @define-color sidebar_shade_color rgba(0, 0, 0, 0.25);

    @define-color secondary_sidebar_bg_color ${xcolors.base02};
    @define-color secondary_sidebar_fg_color ${xcolors.base05};
    @define-color secondary_sidebar_backdrop_color ${xcolors.base01};
    @define-color secondary_sidebar_border_color rgba(0, 0, 0, 0.36);
    @define-color secondary_sidebar_shade_color rgba(0, 0, 0, 0.25);

    @define-color card_bg_color rgba(255, 255, 255, 0.08);
    @define-color card_fg_color ${xcolors.base05};
    @define-color card_shade_color rgba(0, 0, 0, 0.36);

    @define-color thumbnail_bg_color ${xcolors.base01};
    @define-color thumbnail_fg_color ${xcolors.base05};

    @define-color dialog_bg_color ${xcolors.base01};
    @define-color dialog_fg_color ${xcolors.base05};

    @define-color popover_bg_color ${xcolors.base01};
    @define-color popover_fg_color ${xcolors.base05};

    @define-color shade_color rgba(0, 0, 0, 0.25);
    @define-color scrollbar_outline_color rgba(0, 0, 0, 0.5);
  '';
in
  lib.mkIf osConfig.modules.system.desktop.enable
  {
    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3${lib.optionalString (polarity == "dark") "-dark"}";
        package = pkgs.adw-gtk3;
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      font = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font";
        size = 10;
      };

      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

      gtk3 = {
        bookmarks = [
          "file://${config.home.homeDirectory}/Documents"
          "file://${config.home.homeDirectory}/Downloads"
          "file://${config.home.homeDirectory}/Music"
          "file://${config.home.homeDirectory}/Pictures"
          "file://${config.home.homeDirectory}/Videos"
        ];
        extraCss = cssContent;
      };

      gtk4.extraCss = cssContent;
    };

    home.pointerCursor = {
      gtk.enable = true;
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 24;
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk";
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-${polarity}";
  }
