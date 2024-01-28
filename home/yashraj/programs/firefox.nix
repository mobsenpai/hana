{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    policies = {
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://dns.quad9.net/dns-query";
      };
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection.Value = true;
      Homepage.StartPage = "previous-session";
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
    };

    profiles.yashraj = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        proton-pass
        tree-style-tab
        ublock-origin
      ];

      search.default = "DuckDuckGo";
      settings = {
        "browser.download.panel.shown" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "dom.security.https_only_mode" = true;
      };
    };
  };
}
