{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    shadow = true;
    shadowOffsets = [(-40) (-20)];
    shadowOpacity = 0.55;
    shadowExclude = [
      "_GTK_FRAME_EXTENTS@:c"
      "_PICOM_SHADOW@:32c = 0"
      "_NET_WM_WINDOW_TYPE:a = '_NET_WM_WINDOW_TYPE_NOTIFICATION'"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "class_g = 'Conky'"
      "class_g = 'slop'"
      "window_type = 'combo'"
      "window_type = 'desktop'"
      "window_type = 'dnd'"
      "window_type = 'dock'"
      "window_type = 'dropdown_menu'"
      "window_type = 'menu'"
      "window_type = 'notification'"
      "window_type = 'popup_menu'"
      "window_type = 'splash'"
      "window_type = 'toolbar'"
      "window_type = 'utility'"
    ];

    fade = true;
    fadeDelta = 10;
    fadeSteps = [0.03 0.03];
    fadeExclude = [
      "window_type = 'combo'"
      "window_type = 'desktop'"
      "window_type = 'dock'"
      "window_type = 'dnd'"
      "window_type = 'notification'"
      "window_type = 'toolbar'"
      "window_type = 'unknown'"
      "window_type = 'utility'"
      "_PICOM_FADE@:32c = 0"
    ];

    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    menuOpacity = 1.0;
    opacityRules = [
      "70:class_g = 'splash'"
      "100:class_i = 'tray'"
      "90:class_g = 'XTerm'"
      "90:class_g = 'Alacritty'"
      "90:class_g = 'kitty'"
    ];

    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        focus = true;
        full-shadow = true;
      };
      dock = {shadow = false;};
      dnd = {shadow = false;};
      popup_menu = {opacity = 1;};
      dropdown_menu = {opacity = 1;};
      desktop = {full-shadow = false;};
      normal = {full-shadow = false;};
    };

    settings = {
      shadow-radius = 40;
      shadow-color = "#000000";
      shadow-ignore-shaped = false;

      frame-opacity = 1.0;
      inactive-opacity-override = false;
      focus-exclude = [
        "class_g = 'Cairo-clock'"
        "class_g = 'Peek'"
        "window_type = 'notification'"
        "window_type = 'combo'"
        "window_type = 'desktop'"
        "window_type = 'dialog'"
        "window_type = 'dnd'"
        "window_type = 'dock'"
        "window_type = 'dropdown_menu'"
        "window_type = 'menu'"
        "window_type = 'tooltip'"
        "window_type = 'unknown'"
        "window_type = 'utility'"
      ];

      corner-radius = 15;
      rounded-corners-exclude = [
        "_PICOM_SHADOW@:32c = 0"
        "window_type = 'dock'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_MAXIMIZED_VERT'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_MAXIMIZED_HORZ'"
        "class_g = 'Rofi'"
      ];

      experimental-backends = true;

      blur = {
        method = "dual_kawase";
        kernel = "11x11gaussian";
        deviation = 1.0;
        strength = 10;
        background = true;
        background-frame = true;
        background-fixed = true;
      };

      blur-background-exclude = [
        "_GTK_FRAME_EXTENTS@:c"
        "window_type = 'combo'"
        "window_type = 'desktop'"
        "window_type = 'dnd'"
        "window_type = 'menu'"
        "window_type = 'toolbar'"
        "window_type = 'tooltip'"
        "window_type = 'utility'"
        "window_type = 'unknown'"
        "class_g = 'firefox' && window_type != 'normal'"
        "class_g = 'slop'"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      glx-no-stencil = true;
      use-damage = true;
      transparent-clipping = false;
      unredir-if-possible = false;
      log-level = "warn";
    };
  };
}
