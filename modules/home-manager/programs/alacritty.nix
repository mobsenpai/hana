{
  config,
  lib,
  ...
}: {
  options = {
    myHome.alacritty.enable = lib.mkEnableOption "Enables alacritty";
  };

  config = lib.mkIf config.myHome.alacritty.enable {
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
          normal = {
            family = "FiraMono Nerd Font";
            style = "Regular";
          };

          size = 10;
        };

        cursor = {
          style.shape = "Beam";
          unfocused_hollow = false;
        };

        colors = with config.myHome.colorscheme; {
          primary = {
            background = xcolors.bg0;
            foreground = xcolors.fg1;
          };

          cursor = {
            text = xcolors.bg1;
            cursor = xcolors.fg4;
          };

          selection = {
            background = xcolors.bg2;
            text = "CellForeground";
          };

          normal = {
            black = xcolors.bg0;
            red = xcolors.red0;
            green = xcolors.green0;
            yellow = xcolors.yellow0;
            blue = xcolors.blue0;
            magenta = xcolors.purple0;
            cyan = xcolors.aqua0;
            white = xcolors.gray1;
          };

          bright = {
            black = xcolors.gray0;
            red = xcolors.red1;
            green = xcolors.green1;
            yellow = xcolors.yellow1;
            blue = xcolors.blue1;
            magenta = xcolors.purple1;
            cyan = xcolors.aqua1;
            white = xcolors.fg1;
          };
        };
      };
    };
  };
}
