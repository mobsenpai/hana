{
  pkgs,
  config,
  ...
}: {
  services.picom = {
    enable = true;
    settings = {
      corner-radius = 15;

      rounded-corners-exclude = [
        "class_g = 'awesome'"
        "class_i = 'tray'"
        "window_type = 'tooltip'"
        "window_type = 'panel'"
        "window_type = 'popup_menu'"
      ];

      shadow = false;

      fading = false;

      blur = false;

      experimental-backends = true;
      backend = "glx";
    };
  };
}
