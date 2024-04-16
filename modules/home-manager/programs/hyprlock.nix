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
    myhome.hyprlock.enable = lib.mkEnableOption "enables hyprlock";
  };

  config = lib.mkIf config.myhome.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
      };

      backgrounds = [
        {
          path = "";
          color = "rgba(0, 0, 0, 0.5)";
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
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgb(200, 200, 200)";
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
          color = "rgb(255, 255, 255)";
          font_size = 80;
          font_family = "JetBrainsMono Nerd Font ExtraBold";
          position = {
            x = 0;
            y = -200;
          };
          halign = "center";
          valign = "top";
        }
        {
          text = "Hi there, $USER";
          color = "rgb(255, 255, 255)";
          font_size = 18;
          font_family = "JetBrainsMono Nerd Font";
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
