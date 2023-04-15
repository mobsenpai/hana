{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override {
      plugins = [pkgs.rofi-emoji];
    };

    extraConfig = {
      modi = "drun,run";
      show-icons = false;
      display-drun = "";
      display-run = "";
      display-filebrowser = "";
      display-window = "";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        font = "monospace bold 8";
        background = mkLiteral "#282828FF";
        background-alt = mkLiteral "#353535FF";
        foreground = mkLiteral "#EBDBB2FF";
        selected = mkLiteral "#83A598FF";
        active = mkLiteral "#B8BB26FF";
        urgent = mkLiteral "#FB4934FF";

        border-colour = mkLiteral "var(selected)";
        handle-colour = mkLiteral "var(foreground)";
        background-colour = mkLiteral "var(background)";
        foreground-colour = mkLiteral "var(foreground)";
        alternate-background = mkLiteral "var(background-alt)";
        normal-background = mkLiteral "var(background)";
        normal-foreground = mkLiteral "var(foreground)";
        urgent-background = mkLiteral "var(urgent)";
        urgent-foreground = mkLiteral "var(background)";
        active-background = mkLiteral "var(active)";
        active-foreground = mkLiteral "var(background)";
        selected-normal-background = mkLiteral "var(selected)";
        selected-normal-foreground = mkLiteral "var(background)";
        selected-urgent-background = mkLiteral "var(active)";
        selected-urgent-foreground = mkLiteral "var(background)";
        selected-active-background = mkLiteral "var(urgent)";
        selected-active-foreground = mkLiteral "var(background)";
        alternate-normal-background = mkLiteral "var(background)";
        alternate-normal-foreground = mkLiteral "var(foreground)";
        alternate-urgent-background = mkLiteral "var(urgent)";
        alternate-urgent-foreground = mkLiteral "var(background)";
        alternate-active-background = mkLiteral "var(active)";
        alternate-active-foreground = mkLiteral "var(background)";
      };

      "window" = {
        /*
        properties for window widget
        */
        transparency = "real";
        location = mkLiteral "north";
        anchor = mkLiteral "north";
        fullscreen = false;
        width = mkLiteral "100%";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";

        children = mkLiteral "[ horibox ]";

        /*
        properties for all widgets
        */
        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        cursor = mkLiteral "default";
        # /* Backgroud Colors */
        background-color = mkLiteral "@background-colour";
        # /* Backgroud Image */
        # //background-image = mkLiteral          "url("/path/to/image.png", none)";
        # /* Simple Linear Gradient */
        # //background-image = mkLiteral          "linear-gradient(red, orange, pink, purple)";
        # /* Directional Linear Gradient */
        # //background-image = mkLiteral          "linear-gradient(to bottom, pink, yellow, magenta)";
        # /* Angle Linear Gradient */
        # //background-image = mkLiteral          "linear-gradient(45, cyan, purple, indigo)";
      };

      "horibox" = {
        spacing = mkLiteral "0px";
        background-color = mkLiteral "@background-colour";
        text-color = mkLiteral "@foreground-colour";
        orientation = mkLiteral "horizontal";
        children = mkLiteral "[ prompt, textbox-prompt-colon, entry, listview ]";
      };

      "mainbox" = {
        enabled = true;
        spacing = mkLiteral "20px";
        margin = mkLiteral "0px";
        padding = mkLiteral "40px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        children = mkLiteral "[ inputbar, message, listview, mode-switcher ]";
      };

      "inputbar" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "8px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "4px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@alternate-background";
        text-color = mkLiteral "@foreground-colour";
        children = mkLiteral "[ prompt, entry ]";
      };

      "prompt" = {
        enabled = true;
        padding = mkLiteral "10px";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "textbox-prompt-colon" = {
        enabled = true;
        padding = mkLiteral "10px 0px 10px 0px";
        expand = false;
        str = "::";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "entry" = {
        enabled = true;
        padding = mkLiteral "10px";
        expand = false;
        width = mkLiteral "20em";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "search...";
        placeholder-color = mkLiteral "inherit";
      };

      "um-filtered-rows" = {
        enabled = true;
        expand = false;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "textbox-num-sep" = {
        enabled = true;
        expand = false;
        str = "/";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "num-rows" = {
        enabled = true;
        expand = false;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "case-indicator" = {
        enabled = true;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "listview" = {
        enabled = true;
        columns = mkLiteral "1";
        lines = mkLiteral "100";
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "horizontal";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;

        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
        cursor = "default";
      };
      "scrollbar" = {
        handle-width = mkLiteral "5px";
        handle-color = mkLiteral "@handle-colour";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@alternate-background";
      };

      "element" = {
        enabled = true;
        spacing = mkLiteral "8px";
        margin = mkLiteral "0px";
        padding = mkLiteral "10px 8px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
        cursor = mkLiteral "pointer";
      };
      "element normal.normal" = {
        background-color = mkLiteral "var(normal-background)";
        text-color = mkLiteral "var(normal-foreground)";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "var(urgent-background)";
        text-color = mkLiteral "var(urgent-foreground)";
      };
      "element normal.active" = {
        background-color = mkLiteral "var(active-background)";
        text-color = mkLiteral "var(active-foreground)";
      };
      "element selected.normal" = {
        background-color = mkLiteral "white / 5%";
        text-color = mkLiteral "@foreground";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "var(selected-urgent-background)";
        text-color = mkLiteral "var(selected-urgent-foreground)";
      };
      "element selected.active" = {
        background-color = mkLiteral "var(selected-active-background)";
        text-color = mkLiteral "var(selected-active-foreground)";
      };
      "element alternate.normal" = {
        background-color = mkLiteral "var(alternate-normal-background)";
        text-color = mkLiteral "var(alternate-normal-foreground)";
      };
      "element alternate.urgent" = {
        background-color = mkLiteral "var(alternate-urgent-background)";
        text-color = mkLiteral "var(alternate-urgent-foreground)";
      };
      "element alternate.active" = {
        background-color = mkLiteral "var(alternate-active-background)";
        text-color = mkLiteral "var(alternate-active-foreground)";
      };
      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "24px";
        cursor = mkLiteral "inherit";
      };
      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        highlight = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      "mode-switcher" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "4px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@alternate-background";
        text-color = mkLiteral "@foreground-colour";
      };
      "button" = {
        padding = mkLiteral "8px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "4px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };
      "button selected" = {
        background-color = mkLiteral "var(normal-foreground)";
        text-color = mkLiteral "var(normal-background)";
      };

      "message" = {
        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px 0px 0px 0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground-colour";
      };
      "textbox" = {
        padding = mkLiteral "8px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        border-color = mkLiteral "@border-colour";
        background-color = mkLiteral "@alternate-background";
        text-color = mkLiteral "@foreground-colour";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        highlight = mkLiteral "none";
        placeholder-color = mkLiteral "@foreground-colour";
        blink = true;
        markup = true;
      };
      "error-message" = {
        padding = mkLiteral "100px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "black / 10%";
        text-color = mkLiteral "@foreground";
      };
    };
  };
}
