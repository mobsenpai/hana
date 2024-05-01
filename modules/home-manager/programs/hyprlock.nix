{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hyprlock.homeManagerModules.hyprlock
  ];

  options = {
    myHome.hyprlock.enable = lib.mkEnableOption "Enables hyprlock";
  };

  config = lib.mkIf config.myHome.hyprlock.enable {
    programs.hyprlock = with config.myHome.colorscheme; {
      enable = true;
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
      };

      backgrounds = [
        {
          path = config.myHome.wallpaper;
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      input-fields = [
        {
          size = {
            width = 200;
            height = 50;
          };
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
          position = {
            x = 0;
            y = -100;
          };
          halign = "center";
          valign = "center";
        }
      ];
      labels = [
        {
          text = "$TIME";
          color = "rgb(${colors.fg1})";
          font_size = 80;
          font_family = "FiraMono Nerd Font Bold";
          position = {
            x = 0;
            y = -200;
          };
          halign = "center";
          valign = "top";
        }
        {
          text = "Hi there, $USER";
          color = "rgb(${colors.fg1})";
          font_size = 18;
          font_family = "FiraMono Nerd Font";
          position = {
            x = 0;
            y = -30;
          };
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
