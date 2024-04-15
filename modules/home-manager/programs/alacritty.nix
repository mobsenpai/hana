{
  config,
  lib,
  ...
}: {
  options = {
    myhome.alacritty.enable = lib.mkEnableOption "enables alacritty";
  };

  config = lib.mkIf config.myhome.alacritty.enable {
    home.sessionVariables.TERMINAL = "alacritty";

    programs.alacritty = {
      enable = true;
      settings = with config.myhome.colorscheme.xcolors; {
        window = {
          padding = {
            x = 30;
            y = 30;
          };

          dynamic_padding = true;
        };

        font = {
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold Italic";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };

          size = 10;
        };

        cursor.style = {
          shape = "Underline";
        };

        colors = {
          primary = {
            background = black;
            foreground = brightwhite;
          };

          normal = {
            black = black;
            red = red;
            green = green;
            yellow = yellow;
            blue = blue;
            magenta = magenta;
            cyan = cyan;
            white = white;
          };

          bright = {
            black = brightblack;
            red = brightred;
            green = brightgreen;
            yellow = brightyellow;
            blue = brightblue;
            magenta = brightmagenta;
            cyan = brightcyan;
            white = brightwhite;
          };
        };
      };
    };
  };
}
