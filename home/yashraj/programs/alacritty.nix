{config, ...}: let
  inherit (config) colorscheme;
in {
  programs.alacritty = {
    enable = true;
    settings = {
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

      colors = with colorscheme.colors; {
        primary = {
          background = "0x${base00}";
          foreground = "0x${base05}";
        };

        cursor = {cursor = "0x${base07}";};

        normal = {
          black = "0x${base00}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base0A}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base05}";
        };

        bright = {
          black = "0x${base03}";
          red = "0x${base08}";
          green = "0x${base0B}";
          yellow = "0x${base0A}";
          blue = "0x${base0D}";
          magenta = "0x${base0E}";
          cyan = "0x${base0C}";
          white = "0x${base07}";
        };
      };
    };
  };
}
