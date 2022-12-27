{
  pkgs,
  config,
  ...
}: {
  services.picom = {
    enable = true;
    settings = {
      # transition-length = 100;
      # transition-pow-x = 0.1;
      # transition-pow-y = 0.1;
      # transition-pow-w = 0.1;
      # transition-pow-h = 0.1;
      # size-transition = true;
      corner-radius = 15;
      rounded-corners-exclude = [
        #"window_type = 'normal'",
        "class_g = 'awesome'"
        "class_g = 'Polybar'"
        "class_i = 'tray'"
        "class_g = 'Dunst'"
        "class_g = 'code-oss'"
        # "window_type = 'tooltip'"
        # "window_type = 'panel'"
        # "window_type = 'popup_menu'"
      ];
      round-borders = 1;
      round-borders-exclude = [
        #"class_g = 'TelegramDesktop'",
      ];

      shadow = false;

      shadow-radius = 7;

      shadow-offset-x = -7;

      shadow-offset-y = -7;

      shadow-exclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "class_g = 'slop'"
        "class_g = 'Polybar'"
        "class_i = 'tray'"
        "_GTK_FRAME_EXTENTS@:c"
        "class_g = 'firefox' && window_type = 'utility'"
      ];

      fading = false;

      # fade-in-step = 0.03;

      # fade-out-step = 0.03;

      # fade-delta = 10;

      fade-exclude = [
        "class_g = 'slop'" # maim
        "class_i = 'tray'"
      ];

      inactive-opacity-override = false;

      active-opacity = 1.0;

      focus-exclude = [
        "class_g = 'Cairo-clock'"
        "class_g = 'Bar'" # lemonbar
        "class_g = 'slop'" # maim
      ];

      opacity-rule = [
        "80:class_g     = 'Bar'" # lemonbar
        "100:class_g    = 'slop'" # maim
        "90:class_g    = 'XTerm'"
        "100:class_g    = 'URxvt'"
        "100:class_g    = 'kitty'"
        "100:class_g     = 'Alacritty'"
        "90:class_g     = 'Xfce4-terminal'"
        "100:class_g    = 'Polybar'"
        "100:class_i    = 'tray'"
        "100:class_g    = 'code-oss'"
        "100:class_g =   'Code'"
        "100:class_g    = 'Meld'"
        "70:class_g     = 'TelegramDesktop'"
        "90:class_g     = 'Joplin'"
        "100:class_g    = 'firefox'"
        "90:class_g     = 'Rofi'"
        "100:class_g    = 'Thunderbird'"
      ];

      # blur = {
      #   method = "dual_kawase";
      #   strength = 7;
      #   # deviation = 1.0;
      #   # kernel = "11x11gaussian";
      #   background = false;
      #   background-frame = false;
      #   background-fixed = false;
      #   kern = "3x3box";
      # };
      blur = false;

      blur-background-exclude = [
        "window_type = 'dock'"
        #"window_type = 'desktop'",
        "class_i = 'tray'"
        "class_g = 'XAVA'"
        #"class_g = 'URxvt'",
        "class_g = 'slop'"
        "class_g = 'Dunst'"
        "class_g = 'firefox' && window_type = 'utility'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      # daemon = false;

      experimental-backends = true;
      backend = "glx";
      #backend = "xrender";

      vsync = true;

      # Enable remote control via D-Bus. See the *D-BUS API* section below for more details.
      # dbus = false

      # Try to detect WM windows (a non-override-redirect window with no
      # child that has 'WM_STATE') and mark them as active.
      #
      # mark-wmwin-focused = false
      mark-wmwin-focused = true;

      # Mark override-redirect windows that doesn't have a child window with 'WM_STATE' focused.
      # mark-ovredir-focused = false
      mark-ovredir-focused = true;

      # Try to detect windows with rounded corners and don't consider them
      # shaped windows. The accuracy is not very high, unfortunately.
      #
      # detect-rounded-corners = false
      detect-rounded-corners = true;

      # Detect '_NET_WM_OPACITY' on client windows, useful for window managers
      # not passing '_NET_WM_OPACITY' of client windows to frame windows.
      #
      # detect-client-opacity = false
      detect-client-opacity = true;

      # Specify refresh rate of the screen. If not specified or 0, picom will
      # try detecting this with X RandR extension.
      #
      # refresh-rate = 60
      refresh-rate = 0;

      # Unredirect all windows if a full-screen opaque window is detected,
      # to maximize performance for full-screen windows. Known to cause flickering
      # when redirecting/unredirecting windows. paint-on-overlay may make the flickering less obvious.
      #
      unredir-if-possible = true;

      # Delay before unredirecting the window, in milliseconds. Defaults to 0.
      # unredir-if-possible-delay = 0

      # Conditions of windows that shouldn't be considered full-screen for unredirecting screen.
      # unredir-if-possible-exclude = []

      # Use 'WM_TRANSIENT_FOR' to group windows, and consider windows
      # in the same group focused at the same time.
      #
      # detect-transient = false
      detect-transient = true;

      # Use 'WM_CLIENT_LEADER' to group windows, and consider windows in the same
      # group focused at the same time. 'WM_TRANSIENT_FOR' has higher priority if
      # detect-transient is enabled, too.
      #
      # detect-client-leader = false
      detect-client-leader = true;

      #Changing use-damage to false fixes the problem
      use-damage = false;

      # log-level = "debug"
      log-level = "info";

      wintypes = {
        normal = {
          fade = false;
          shadow = false;
        };
        #tooltip = { fade = true; shadow = true; opacity = 0.75; focus = true; full-shadow = false; };
        dock = {shadow = false;};
        dnd = {shadow = false;};
        #popup_menu = { opacity = 0.8; }
        #dropdown_menu = { opacity = 0.8; }
      };
    };
  };
}
