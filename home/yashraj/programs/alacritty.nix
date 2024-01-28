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
          background = xcolors.base00;
          foreground = xcolors.base05;
        };

        cursor = {cursor = xcolors.base07;};

        normal = {
          black = xcolors.base00;
          red = xcolors.base08;
          green = xcolors.base0B;
          yellow = xcolors.base0A;
          blue = xcolors.base0D;
          magenta = xcolors.base0E;
          cyan = xcolors.base0C;
          white = xcolors.base05;
        };

        bright = {
          black = xcolors.base03;
          red = xcolors.base08;
          green = xcolors.base0B;
          yellow = xcolors.base0A;
          blue = xcolors.base0D;
          magenta = xcolors.base0E;
          cyan = xcolors.base0C;
          white = xcolors.base07;
        };
      };
    };
  };
}
