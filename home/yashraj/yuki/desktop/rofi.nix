{
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override {
      plugins = [pkgs.rofi-emoji];
    };

    theme = let
      # Use `mkLiteral` for string-like values that should show without
      # quotes, e.g.:
      # {
      #   foo = "abc"; =&gt; foo: "abc";
      #   bar = mkLiteral "abc"; =&gt; bar: abc;
      # };
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "configuration" = {
        modi = "drun,run,filebrowser";
        show-icons = false;
        display-drun = "drun";
        display-run = "run";
        display-filebrowser = "files";
        display-window = "windows";
        drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        window-format = "{w} · {c} · {t}";
      };

      "*" = with colors; {
        font = "monospace bold 8";
        background = mkLiteral "#${base00}ff";
        background-alt = mkLiteral "#${base01}ff";
        foreground = mkLiteral "#${base05}ff";
        selected = mkLiteral "#${base0D}ff";
        active = mkLiteral "#${base0B}ff";
        urgent = mkLiteral "#${base08}ff";

        border-colour = mkLiteral "var(selected)";
        handle-colour = mkLiteral "var(selected)";
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

      /*
      ****----- Main Window -----****
      */
      "window" = {
        /*
        properties for window widget
        */
        "transparency" = "real";
        "location" = mkLiteral "center";
        "anchor" = mkLiteral "center";
        "fullscreen" = mkLiteral "false";
        "width" = mkLiteral "1000px";
        "x-offset" = mkLiteral "0px";
        "y-offset" = mkLiteral "0px";

        /*
        properties for all widgets
        */
        "enabled" = mkLiteral "true";
        "margin" = mkLiteral "0px";
        "padding" = mkLiteral "0px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px";
        "border-color" = mkLiteral "@border-colour";
        "cursor" = "default";
        "background-color" = mkLiteral "@background-colour";
      };

      /*
      ****----- Main Box -----****
      */
      "mainbox" = {
        "enabled" = mkLiteral "true";
        "spacing" = mkLiteral "10px";
        "margin" = mkLiteral "0px";
        "padding" = mkLiteral "40px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px 0px 0px 0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "transparent";
        "children" = mkLiteral "[ inputbar, message, listview, mode-switcher ]";
      };

      /*
      ****----- Inputbar -----****
      */
      "inputbar" = {
        "enabled" = mkLiteral "true";
        "spacing" = mkLiteral "10px";
        "margin" = mkLiteral "0px";
        "padding" = mkLiteral "0px 5px";
        "border" = mkLiteral "0px";
        "border-radius" = mkLiteral "0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "@background-colour";
        "text-color" = mkLiteral "@foreground-colour";
        "children" = mkLiteral "[ prompt, textbox-prompt-colon, entry ]";
      };

      "prompt" = {
        "enabled" = mkLiteral "true";
        "background-color" = mkLiteral "inherit";
        "text-color" = mkLiteral "inherit";
      };
      "textbox-prompt-colon" = {
        "enabled" = mkLiteral "true";
        "expand" = mkLiteral "false";
        "str" = ":";
        "background-color" = mkLiteral "inherit";
        "text-color" = mkLiteral "inherit";
      };
      "entry" = {
        "enabled" = mkLiteral "true";
        "background-color" = mkLiteral "inherit";
        "text-color" = mkLiteral "inherit";
        "cursor" = mkLiteral "text";
        "placeholder" = "search...";
        "placeholder-color" = mkLiteral "inherit";
      };

      /*
      ****----- Listview -----****
      */
      "listview" = {
        "enabled" = mkLiteral "true";
        "columns" = mkLiteral "3";
        "lines" = mkLiteral "10";
        "cycle" = mkLiteral "true";
        "dynamic" = mkLiteral "true";
        "scrollbar" = mkLiteral "false";
        "layout" = mkLiteral "vertical";
        "reverse" = mkLiteral "false";
        "fixed-height" = mkLiteral "true";
        "fixed-columns" = mkLiteral "true";

        "spacing" = mkLiteral "0px";
        "margin" = mkLiteral "0px";
        "padding" = mkLiteral "0px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "transparent";
        "text-color" = mkLiteral "@foreground-colour";
        "cursor" = "default";
      };
      "scrollbar" = {
        "handle-width" = mkLiteral "5px ";
        "handle-color" = mkLiteral "@handle-colour";
        "border-radius" = mkLiteral "0px";
        "background-color" = mkLiteral "@alternate-background";
      };

      /*
      ****----- Elements -----****
      */
      "element" = {
        "enabled" = mkLiteral "true";
        "spacing" = mkLiteral "10px";
        "margin" = mkLiteral "0px";
        "padding" = mkLiteral "5px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "transparent";
        "text-color" = mkLiteral "@foreground-colour";
        "cursor" = mkLiteral "pointer";
      };
      "element normal.normal" = {
        "background-color" = mkLiteral "var(normal-background)";
        "text-color" = mkLiteral "var(normal-foreground)";
      };
      "element normal.urgent" = {
        "background-color" = mkLiteral "var(urgent-background)";
        "text-color" = mkLiteral "var(urgent-foreground)";
      };
      "element normal.active" = {
        "background-color" = mkLiteral "var(active-background)";
        "text-color" = mkLiteral "var(active-foreground)";
      };
      "element selected.normal" = {
        "background-color" = mkLiteral "var(selected-normal-foreground)";
        "text-color" = mkLiteral "var(selected-normal-background)";
      };
      "element selected.urgent" = {
        "background-color" = mkLiteral "var(selected-urgent-background)";
        "text-color" = mkLiteral "var(selected-urgent-foreground)";
      };
      "element selected.active" = {
        "background-color" = mkLiteral "var(selected-active-background)";
        "text-color" = mkLiteral "var(selected-active-foreground)";
      };
      "element alternate.normal" = {
        "background-color" = mkLiteral "var(alternate-normal-background)";
        "text-color" = mkLiteral "var(alternate-normal-foreground)";
      };
      "element alternate.urgent" = {
        "background-color" = mkLiteral "var(alternate-urgent-background)";
        "text-color" = mkLiteral "var(alternate-urgent-foreground)";
      };
      "element alternate.active" = {
        "background-color" = mkLiteral "var(alternate-active-background)";
        "text-color" = mkLiteral "var(alternate-active-foreground)";
      };
      "element-icon" = {
        "background-color" = mkLiteral "transparent";
        "text-color" = mkLiteral "inherit";
        "size" = mkLiteral "24px";
        "cursor" = mkLiteral "inherit";
      };
      "element-text" = {
        "background-color" = mkLiteral "transparent";
        "text-color" = mkLiteral "inherit";
        "highlight" = mkLiteral "inherit";
        "cursor" = mkLiteral "inherit";
        "vertical-align" = mkLiteral "0.5";
        "horizontal-align" = mkLiteral "0.0";
      };

      /*
      ****----- Mode Switcher -----****
      */
      "mode-switcher" = {
        "enabled" = mkLiteral "true";
        "spacing" = mkLiteral "0px";
        "margin" = mkLiteral "0px";
        "padding" = mkLiteral "0px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "transparent";
        "text-color" = mkLiteral "@foreground-colour";
      };
      "button" = {
        "padding" = mkLiteral "5px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "@background-colour";
        "text-color" = mkLiteral "inherit";
        "cursor" = mkLiteral "pointer";
      };
      "button selected" = {
        "background-color" = mkLiteral "var(alternate-background)";
        "text-color" = mkLiteral "var(selected-normal-background)";
      };

      /*
      ****----- Message -----****
      */
      "message" = {
        "enabled" = mkLiteral "true";
        "margin" = mkLiteral "0px";
        "padding" = mkLiteral "0px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px 0px 0px 0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "transparent";
        "text-color" = mkLiteral "@foreground-colour";
      };
      "textbox" = {
        "padding" = mkLiteral "5px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "@background-colour";
        "text-color" = mkLiteral "@border-colour";
        "vertical-align" = mkLiteral "0.5";
        "horizontal-align" = mkLiteral "0.0";
        "highlight" = mkLiteral "none";
        "placeholder-color" = mkLiteral "@foreground-colour";
        "blink" = mkLiteral "true";
        "markup" = mkLiteral "true";
      };
      "error-message" = {
        "padding" = mkLiteral "20px";
        "border" = mkLiteral "0px solid";
        "border-radius" = mkLiteral "0px";
        "border-color" = mkLiteral "@border-colour";
        "background-color" = mkLiteral "@background-colour";
        "text-color" = mkLiteral "@foreground-colour";
      };
    };
  };
}
