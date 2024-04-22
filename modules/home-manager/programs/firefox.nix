{
  config,
  lib,
  pkgs,
  ...
}: let
  mimeTypes = [
    "application/json"
    "application/pdf"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
    "application/xhtml+xml"
    "text/html"
    "text/xml"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/http"
    "x-scheme-handler/unknown"
    "x-scheme-handler/https"
  ];
in {
  options = {
    myhome.firefox.enable = lib.mkEnableOption "Enables firefox";
  };

  config = lib.mkIf config.myhome.firefox.enable {
    home.sessionVariables.BROWSER = "firefox";
    xdg.mimeApps.defaultApplications = builtins.listToAttrs (map (mimeType: {
        name = mimeType;
        value = ["firefox.desktop"];
      })
      mimeTypes);

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

        search = {
          force = true;
          default = "DuckDuckGo";
        };
        settings = {
          "browser.download.panel.shown" = true;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "dom.security.https_only_mode" = true;
        };
      };
    };
  };
}
