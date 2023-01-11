{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    # MOZ_USE_XINPUT2 = "1";
    # Required to use va-api with Firefox
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

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

        userChrome = ''
          @import "${pkgs.firefox-csshacks}/share/firefox-csshacks/chrome/tabs_on_bottom.css";
          @import "${pkgs.firefox-csshacks}/share/firefox-csshacks/chrome/combined_favicon_and_tab_close_button.css";
        '';
        # userContent = import ./userContent-css.nix {
        #   inherit (config) colorscheme;
        # };

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("browser.compactmode.show", true);
          user_pref("browser.uidensity", 1);

          // Arkenfox User.js
          ${builtins.readFile "${pkgs.arkenfox}/share/arkenfox/user.js"}

          // Arkenfox overrides
          user_pref('keyword.enabled', true);
          user_pref('privacy.resistFingerprinting.letterboxing', false);
          user_pref('privacy.sanitize.sanitizeOnShutdown', false);
          user_pref('privacy.clearOnShutdown.offlineApps', false);
          user_pref("browser.startup.page", 3);
          user_pref("browser.startup.homepage", "moz-extension://b2b767bc-408e-4254-ba65-a39168d8ee25/index.html");
          user_pref("browser.newtabpage.enabled", true);
          user_pref("media.eme.enabled", true);
          user_pref("network.http.referer.XOriginPolicy", 0);
        '';
      };
    };
  };
}
