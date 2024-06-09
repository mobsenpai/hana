{
  config,
  lib,
  ...
}: {
  options = {
    myHome.hyprlock.enable = lib.mkEnableOption "Enables hyprlock";
  };

  config = lib.mkIf config.myHome.hyprlock.enable {
    programs.hyprlock = with config.myHome.colorscheme; {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 3;
        };

        background = [
          {
            path = config.myHome.wallpaper;
            blur_passes = 3;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            outline_thickness = 2;
            dots_size = 0.25;
            dots_spacing = 0.25;
            dots_center = true;
            outer_color = "rgb(${colors.bg0})";
            inner_color = "rgb(${colors.bg0})";
            font_color = "rgb(${colors.fg1})";
            fade_on_empty = false;
            placeholder_text = "<i>Input Password...</i>";
            hide_input = false;
            position = "0, -100";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          {
            text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
            color = "rgb(${colors.fg1})";
            font_size = 80;
            font_family = "FiraMono Nerd Font Bold";
            position = "0, -200";
            halign = "center";
            valign = "top";
          }
          {
            text = "Hi there, $USER";
            color = "rgb(${colors.fg1})";
            font_size = 18;
            font_family = "FiraMono Nerd Font";
            position = "0, -30";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
