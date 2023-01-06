{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #   adnauseam
    #   enhanced-github
    #   enhancer-for-youtube
    #   octotree
    #   refined-github
    #   stylus
    #   ublock-origin
    # ];

    profiles = {
      yashraj = {
        id = 0;
        settings = {
          "general.smoothScroll" = true;
          "gfx.canvas.accelerated" = true;
          "gfx.webrender.enabled" = true;
          "gfx.x11-egl.force-enabled" = true;
          "layers.acceleration.force-enabled" = true;
          "media.av1.enabled" = false;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          "widget.dmabuf.force-enabled" = true;
          "widget.use-xdg-desktop-portal" = true;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.onSaveRecs" = false;
        };

        # userChrome = import ./userChrome-css.nix;
        userChrome = ''
          @import "${pkgs.firefox-csshacks}/share/firefox-csshacks/chrome/tabs_on_bottom.css";
        '';
        # userContent = import ./userContent-css.nix {
        #   inherit (config) colorscheme;
        # };

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("browser.compactmode.show", true);
          user_pref("browser.uidensity", 1);
          user_pref("svg.context-properties.content.enabled", true);
        '';
      };
    };
  };
}
