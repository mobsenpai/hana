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
        "class_g = 'firefox' && window_type = 'utility'"
      ];

      shadow = false;

      fading = false;

      # blur = false;

      experimental-backends = true;
      backend = "glx";

      opacity-rule = [
        "90:class_g    = 'XTerm'"
        "90:class_g     = 'Alacritty'"
        "100:class_i    = 'tray'"
        "100:class_g =   'Code'"
      ];

      blur = {
        method = "kawase";
        strength = 7;
        # deviation = 1.0;
        # kernel = "11x11gaussian";
        background = false;
        background-frame = false;
        background-fixed = false;
        kern = "3x3box";
      };

      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
        "class_i = 'tray'"
        "window_type = 'tooltip'"
        "window_type = 'panel'"
        "window_type = 'popup_menu'"
        "class_g = 'firefox' && window_type = 'utility'"
      ];
    };
  };
}
