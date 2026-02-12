{
  lib,
  config,
  osConfig,
  ...
} @ args: let
  inherit (lib) mkIf utils getExe optionals;
  inherit (config.modules.desktop) primaryBrowser;
  cfg = config.modules.programs.firefox;
in
  mkIf cfg.enable
  {
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;

          extensions.packages = with utils.flakePkgs args "firefox-addons"; [
            proton-pass
            tree-style-tab
            ublock-origin
            vimium-c
          ];

          search = {
            force = true;
            default = "google";
          };

          settings = {
            # General
            "general.autoScroll" = true;
            "extensions.pocket.enabled" = false;
            # Enable userChrome.css modifications
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            # Enable hardware acceleration
            # Firefox only support VAAPI acceleration. This is natively supported
            # by AMD cards but NVIDIA cards need a translation library to go from
            # VDPAU to VAAPI.
            "media.ffmpeg.vaapi.enabled" = osConfig.modules.system.device.gpu.type != null;

            # UI
            "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
            "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
            "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
            "browser.startup.page" = 3;
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.uidensity" = 1;
            "sidebar.main.tools" = "history,bookmarks";
            "sidebar.revamp" = true;

            # QOL
            "browser.aboutConfig.showWarning" = false;
            "doms.forms.autocomplete.formautofill" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "identity.fxaccounts.enabled" = false;
            "signon.management.page.breach-alerts.enabled" = false;

            # Privacy
            "browser.newtabpage.activity-stream.default.sites" = "";
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.ping-centre.telemetry" = false;
            "breakpad.reportURL" = "";
            "browser.tabs.crashReporting.sendReport" = false;
            "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
            "captivedetect.canonicalURL" = "";
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "dom.security.https_only_mode" = true;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;
            "browser.discovery.enabled" = false;
            "network.captive-portal-service.enabled" = false;
            "network.connectivity-service.enabled" = false;
            "network.trr.mode" = 3;
            "network.trr.uri" = "https://dns.quad9.net/dns-query";
            "privacy.trackingprotection.enabled" = true;
            "private.donottrackheader.enabled" = true;
            "private.globalprivacycontrol.enabled" = true;
            "signon.rememberSignons" = false;
            "toolkit.coverage.endpoint.base" = "";
            "toolkit.coverage.opt-out" = true;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
          };
        };
      };
    };

    xdg.mimeApps.defaultApplications = mkIf (primaryBrowser == "Firefox") {
      "text/html" = ["firefox.desktop"];
      "text/xml" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };

    desktop = let
      firefox = getExe config.programs.firefox.package;
    in {
      niri.settings = {
        window-rules = [
          {
            matches = [{app-id = "firefox";}];
            open-maximized = true;
          }
          {
            matches = [
              {
                app-id = "firefox";
                title = "Picture-in-Picture";
              }
            ];

            open-floating = true;
            default-column-width = {proportion = 0.6;};
            default-window-height = {proportion = 0.6;};
          }
        ];

        binds = {
          "Mod+F2" = mkIf (primaryBrowser == "Firefox") {
            action.spawn = firefox;
            hotkey-overlay.title = "Open firefox";
          };
        };
      };

      hyprland.settings = {
        windowrule = [
          "float, class:^(firefox)$, title:^(Picture-in-Picture)$"
          "size 60% 60%, class:^(firefox)$, title:^(Picture-in-Picture)$"
          "center, class:^(firefox)$, title:^(Picture-in-Picture)$"
        ];

        bind = optionals (primaryBrowser == "Firefox") [
          "SUPER, F2, exec, ${firefox}"
        ];
      };
    };
  }
