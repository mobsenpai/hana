{
  config,
  pkgs,
  package,
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

    inherit package;

    profiles = {
      yashraj = {
        id = 0;
        settings = {
          "general.smoothScroll" = true;
        };

        # Note : You can also use colorschemes in firefox instead of extensions if you want
        userChrome = import ./userChrome-css.nix;
        # userContent = import ./userContent-css.nix {
        #   inherit (config) colorscheme;
        # };

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
          user_pref("browser.compactmode.show", true);
        '';
      };
    };
  };
}
