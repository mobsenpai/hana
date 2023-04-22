{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    # Required to use va-api with Firefox
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      extraPolicies = {
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
      };
    };

    profiles = {
      yashraj = {
        id = 0;
        search = {
          force = true;
          default = "DuckDuckGo";
          engines = {
            "SearXNG" = {
              urls = [
                {
                  template = "https://paulgo.io/";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@s"];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@np"];
            };
          };
        };
        settings = {
          "general.smoothScroll" = true;
          "gfx.canvas.accelerated" = true;
          "gfx.webrender.enabled" = true;
          "gfx.x11-egl.force-enabled" = true;
          "layers.acceleration.force-enabled" = true;
          "media.av1.enabled" = false;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          "widget.dmabuf.force-enabled" = true;
          "widget.use-xdg-desktop-portal" = true;
        };

        userChrome = ''
        '';

        userContent = ''
        '';

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("browser.compactmode.show", true);
          user_pref("browser.uidensity", 1);
          user_pref("browser.startup.homepage", "https://mobsenpai.github.io/_traichu/");
          user_pref("network.trr.mode", 2);
          user_pref("network.trr.uri", "https://dns.quad9.net/dns-query");
        '';
      };
    };
  };
}
