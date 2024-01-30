{
  config,
  themes,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = let
      inherit (themes.colorscheme) xcolors;
    in {
      window = {
        padding = {
          x = 30;
          y = 30;
        };

        dynamic_padding = true;
      };

      font = {
        normal = {
          family = "monospace";
          style = "Regular";
        };

        bold = {
          family = "monospace";
          style = "Bold";
        };

        size = config.gtk.font.size;
      };

      cursor.style = {
        shape = "Underline";
      };

      colors = {
        primary = {
          background = xcolors.black;
          foreground = xcolors.brightwhite;
        };

        normal = {
          black = xcolors.black;
          red = xcolors.red;
          green = xcolors.green;
          yellow = xcolors.yellow;
          blue = xcolors.blue;
          magenta = xcolors.magenta;
          cyan = xcolors.cyan;
          white = xcolors.white;
        };

        bright = {
          black = xcolors.brightblack;
          red = xcolors.brightred;
          green = xcolors.brightgreen;
          yellow = xcolors.brightyellow;
          blue = xcolors.brightblue;
          magenta = xcolors.brightmagenta;
          cyan = xcolors.brightcyan;
          white = xcolors.brightwhite;
        };
      };
    };
  };
}
