{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf getExe optionals;
  inherit (config.modules.colorScheme) xcolors polarity;
  inherit (config.modules.desktop.style) font;
  inherit (config.modules.desktop) primaryBrowser;
  cfg = config.modules.programs.qutebrowser;
in
  mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      extraConfig = ''
        c.tabs.padding = {'top': 4, 'bottom': 4, 'right': 8, 'left': 8}
      '';

      keyBindings = {
        normal = {
          gd = "hint inputs";
          ge = "scroll-to-perc 100";
          gf = "hint links";
          gg = "scroll-to-perc 0";
          gn = "tab-next";
          gp = "tab-prev";
          u = "undo";
        };
      };

      loadAutoconfig = false;
      searchEngines = rec {
        DEFAULT = google;
        ddg = duckduckgo;
        duckduckgo = "https://duckduckgo.com/?q={}";
        g = google;
        google = "https://google.com/search?hl=en&q={}";
      };

      settings = {
        auto_save.session = true;
        backend = "webengine";
        colors = {
          completion = {
            category.bg = xcolors.base01;
            category.fg = xcolors.base06;
            even.bg = xcolors.base01;
            fg = xcolors.base06;
            item.selected.bg = xcolors.base0D;
            item.selected.fg = xcolors.base00;
            match.fg = xcolors.base0B;
            odd.bg = xcolors.base02;
          };

          hints = {
            bg = xcolors.base0D;
            fg = xcolors.base00;
            match.fg = xcolors.base0B;
          };

          keyhint = {
            bg = xcolors.base01;
            fg = xcolors.base06;
          };

          messages = {
            error.bg = xcolors.base08;
            error.fg = xcolors.base00;
            info.bg = xcolors.base0D;
            info.fg = xcolors.base00;
          };

          statusbar = {
            command.bg = xcolors.base01;
            command.fg = xcolors.base06;
            insert.bg = xcolors.base0B;
            insert.fg = xcolors.base01;
            normal.bg = xcolors.base00;
            normal.fg = xcolors.base06;
            progress.bg = xcolors.base0D;
            url.error.fg = xcolors.base08;
            url.fg = xcolors.base06;
            url.success.https.fg = xcolors.base0C;
          };

          tabs = {
            bar.bg = xcolors.base00;
            even.bg = xcolors.base01;
            even.fg = xcolors.base04;
            odd.bg = xcolors.base02;
            odd.fg = xcolors.base04;
            selected.even.bg = xcolors.base0D;
            selected.even.fg = xcolors.base00;
            selected.odd.bg = xcolors.base0D;
            selected.odd.fg = xcolors.base00;
          };

          webpage.preferred_color_scheme = polarity;
        };

        confirm_quit = ["downloads"];
        content = {
          autoplay = false;
          blocking = {
            enabled = true;
            adblock.lists = [
              "https://easylist.to/easylist/easylist.txt"
              "https://easylist.to/easylist/easyprivacy.txt"
              "https://filters.adtidy.org/extension/ublock/filters/2.txt"
              "https://abp.oisd.nl"
            ];

            hosts.lists = [
              "https://raw.githubusercontent.com/knapah/uBlockOrigin-Filterlist/refs/heads/main/HOST"
            ];

            method = "auto";
          };

          canvas_reading = true;
          cookies.accept = "no-3rdparty";
          headers.do_not_track = true;
          javascript.alert = false;
          notifications.enabled = false;
          plugins = false;
          webrtc_ip_handling_policy = "default-public-interface-only";
        };

        downloads = {
          location.directory = "~/Downloads";
          location.prompt = true;
        };

        fonts = {
          default_family = font.family;
          default_size = "10pt";
          statusbar = "10pt ${font.family}";
          tabs.selected = "bold 10pt ${font.family}";
          tabs.unselected = "10pt ${font.family}";
        };

        hints = {
          chars = "asdfjkl;wer";
          mode = "letter";
        };

        scrolling.smooth = true;
        session.lazy_restore = true;
        tabs = {
          last_close = "default-page";
          show = "multiple";
          title.alignment = "left";
        };

        url = rec {
          default_page = "mobsenpai.github.io/_traichu/";
          start_pages = [default_page];
        };

        window.hide_decoration = true;
      };
    };

    xdg.mimeApps.defaultApplications = mkIf (primaryBrowser == "Qutebrowser") {
      "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
      "text/xml" = ["org.qutebrowser.qutebrowser.desktop"];
      "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
      "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
      "x-scheme-handler/qute" = ["org.qutebrowser.qutebrowser.desktop"];
    };

    desktop = let
      qutebrowser = getExe config.programs.qutebrowser.package;
    in {
      niri.settings = {
        window-rules = [
          {
            matches = [{app-id = "org.qutebrowser.qutebrowser";}];
            open-maximized = true;
          }
        ];

        binds = {
          "Mod+F2" = mkIf (primaryBrowser == "Qutebrowser") {
            action.spawn = qutebrowser;
            hotkey-overlay.title = "Open Qutebrowser";
          };
        };
      };

      hyprland.settings = {
        windowrule = [
          "maximize, class:^(org\\.qutebrowser\\.qutebrowser)$"
        ];

        bind = optionals (primaryBrowser == "Qutebrowser") [
          "SUPER, F2, exec, ${qutebrowser}"
        ];
      };
    };
  }
