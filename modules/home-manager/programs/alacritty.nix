{
  config,
  lib,
  ...
}: {
  options = {
    myhome.alacritty.enable = lib.mkEnableOption "Enables alacritty";
  };

  config = lib.mkIf config.myhome.alacritty.enable {
    home.sessionVariables.TERMINAL = "alacritty";

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

        colors = with config.myhome.colorscheme; {
          primary = {
            background = xcolors.black;
            foreground = xcolors.white;
          };

          normal = {
            black = xcolors.black;
            red = xcolors.dark-red;
            green = xcolors.dark-green;
            yellow = xcolors.dark-yellow;
            blue = xcolors.dark-blue;
            magenta = xcolors.dark-purple;
            cyan = xcolors.dark-aqua;
            white = xcolors.gray;
          };

          bright = {
            black = xcolors.dark-gray;
            red = xcolors.red;
            green = xcolors.green;
            yellow = xcolors.yellow;
            blue = xcolors.blue;
            magenta = xcolors.purple;
            cyan = xcolors.aqua;
            white = xcolors.white;
          };
        };
      };
    };
  };
}
