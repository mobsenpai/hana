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
          default = "SearXNG";
          engines = {
            "SearXNG" = {
              urls = [
                {
                  template = "https://searx.be/";
                  params = [
                    {
                      name = "preferences";
                      value = "eJx1V02P4zYM_TXNxdhB2z0UPeRUoNcu0L0LtMTYXEuiVh9JPL--VGzH8mR6GCN6-qIeyUeOhowDR8J0HtBjBHuy4IcCA57ByoA1WDyjP0HJrNkFixnPA_Ng8URO1qkQ-T6fv8eCJ4d5ZHP-9s-_308JLpgQoh7Pv57yiA7PnDTEU8RUbE6KvfJ4Uxn6899gE54Mk5JJtleMZwYZvnEcTo9dX1KexRDLA2k2eP1iIE6nRNUgtcxVC08afcaowNLg5Od6MpgreI1GrQYt6M-CcVbkVaYs-x8vIH8hT1nO1JGtXUBDCXor29EP5IWrPwcYlEqsCWzn0BD88vtfEKbOUYwclbqQxfTAxL5Ovl3KHLGZEDPoih0lpVbmH2gmrdSD17qqp9wXPWEWLMtYa_0lX5W6kkGuCzigF7YSNpvE8JQiXsRATSjPFmzG0N6jS7SELWIQ34U35UoiLWOMfCOjFIvnooxvNJGBDIc9Ylr9G7hbLm-MWB7uIAgoX0GyMDcf7vzt3my4mMj1wo2giyU9xXZBROwSX_INInaGImqhdF6ZuUTyE0FL3kCDeA1Sbu8cxNXQb3RKJPUYh3W4RHUXLMzVZWk3pp1xfKX61KcPhsDGtNyN0Eeon_Vc8tAs_0Fp5J3YSZ4JqbnLkuyOc1dtTvTJBF86zX6QTGkJt9ynjG8xrZfCu50j6bSbJckJOoBfF_jgtl8zwH5NDamIgZubA4iNA6UtDEPp3yQH19HPG_gDxw_gNSQWeOGh4SNhIFjy8oBWoDqoq5-nl8FB5WEDEjo5lHSX9MgWYhvzKUs6hapQjW2Zp5kziwumysT2whlG5nbdzCWXHhuLDJCdHWcS3drRKznkZnyjfm7PcRBFMsTmQ-aIpt7Bm3hEa471zFP6CIpMCla_K_CzcMaPqxKXqF_Qqg6U5xeY5w_MGNL5nf0xQ79-_eO-s2SKQb-HbsJ3D-7wWv6BOLWIh2tNjR2IpZ8HdFuYBsT4geiHnsoVk-TZ7YZ9MxWLEx1u6eY7TewlGrs0e_azw8a-H-Et3PxRxJzIe2uP5NT18OYgaWK3ePwUfg1tCck98xY_jCXvsvI86IT-WEke51ny5d5V67bkjXe6trHcS7RocGHP5ro6VKYOjyE_fBy_WvtADzH1QF4ys8-GhmF3v1SNKPbMx7pxJclAybTmAmOGzuCjkEq2HMLZsJSz2I1l0-C9iPxPablhDYa4exElyranP7EsqemFx8b9chqVRv9knKsrFqdQ3m1Y5P1QJhbBf6FuxQ_krdgLfSv-iTKN631LdXCm340mL_uJS3tQg21vkZcO14PrHd215WIavQepiLgVoSrrIEWzFvGE0n419mxzoutSdWF12nE-Zam_WUr5Vs-DqVm7Lwqj6Kp_zlKU1rKHuakipZfUPmyZA7VF5Mir2Goov7RZkl6SC8enitTriUVpLpZvWw6lqfTF57KlZQkYS3oSIn0mGekgJKRzU-vyjXLtID9eW3yS8p_GJhgeReNo87NsNGla6YTaqDxliO1SyMLYhLAT7XLS0HQ5gk9W2GvbL47G09QAOcc32rRt71CDLSIs6VyV6v62jt4Y1NJc36L0tmt53acT2ov0wRd-mRF-lB5RTy8zUviUeHzCOT1F7fPLx8raMng5ZeSUpYagmCbs6s9MewixBJZe_lWZpYe30vq9mhqhSouS1lZOczUaTlLtJXLP_wFzh-BG";
                    }
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
          @import "${pkgs.firefox-csshacks}/chrome/tabs_on_bottom.css";
          @import "${pkgs.firefox-csshacks}/chrome/combined_favicon_and_tab_close_button.css";
        '';

        userContent = ''
        '';

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("browser.compactmode.show", true);
          user_pref("browser.uidensity", 1);
          user_pref("browser.startup.homepage", "https://mobsenpai.github.io/firefoxstartpage/");
          user_pref("network.trr.mode", 2);
          user_pref("network.trr.uri", "https://dns.quad9.net/dns-query");
        '';
      };
    };
  };
}
