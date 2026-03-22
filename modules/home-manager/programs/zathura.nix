{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.programs.zathura;
  inherit (config.modules.colorScheme) xcolors colors;
  inherit (config.modules.desktop.style) font;

  hexToRGBA = hex: alpha: let
    r = lib.fromHexString (builtins.substring 0 2 hex);
    g = lib.fromHexString (builtins.substring 2 2 hex);
    b = lib.fromHexString (builtins.substring 4 2 hex);
  in "rgba(${toString r},${toString g},${toString b},${alpha})";
in
  lib.mkIf cfg.enable
  {
    programs.zathura = {
      enable = true;

      package = (pkgs.zathuraPkgs.override {useMupdf = false;}).zathuraWrapper;

      options = {
        default-bg = xcolors.base00;
        default-fg = xcolors.base05;
        statusbar-bg = xcolors.base00;
        statusbar-fg = xcolors.base05;
        inputbar-bg = xcolors.base00;
        inputbar-fg = xcolors.base07;
        notification-error-bg = xcolors.base08;
        notification-error-fg = xcolors.base00;
        notification-warning-bg = xcolors.base08;
        notification-warning-fg = xcolors.base00;
        highlight-color = hexToRGBA colors.base0A "0.3";
        highlight-active-color = hexToRGBA colors.base0D "0.3";
        completion-highlight-fg = xcolors.base02;
        completion-highlight-bg = xcolors.base0C;
        completion-bg = xcolors.base02;
        completion-fg = xcolors.base0C;
        notification-bg = xcolors.base0B;
        notification-fg = xcolors.base00;

        recolor = "false";
        recolor-lightcolor = xcolors.base00;
        recolor-darkcolor = xcolors.base06;
        recolor-reverse-video = "true";
        recolor-keephue = "true";

        font = "${font.family} 10";
        adjust-open = "best-fit";
        pages-per-row = 1;
        scroll-page-aware = true;
        scroll-step = 50;
        render-loading = false;
        selection-clipboard = "clipboard";
        database = "null"; # disable history
      };

      mappings = {
        # Smooth scroll with j/k
        "j feedkeys" = "<C-Down>";
        "k feedkeys" = "<C-Up>";

        # Page navigation with J/K
        "J" = "navigate next";
        "K" = "navigate previous";

        # Toggle dark theme
        "<C-l>" = "recolor";
      };
    };

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
    };

    programs.zsh.shellAliases = {
      pdf = "zathura";
    };
  }
