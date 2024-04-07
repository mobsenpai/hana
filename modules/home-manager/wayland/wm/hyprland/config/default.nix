#███╗░░░███╗░█████╗░██████╗░██╗░██████╗  ██╗░░██╗██╗░░░██╗██████╗░██████╗░██╗░░░░░░█████╗░███╗░░██╗██████╗░
#████╗░████║██╔══██╗██╔══██╗╚█║██╔════╝  ██║░░██║╚██╗░██╔╝██╔══██╗██╔══██╗██║░░░░░██╔══██╗████╗░██║██╔══██╗
#██╔████╔██║██║░░██║██████╦╝░╚╝╚█████╗░  ███████║░╚████╔╝░██████╔╝██████╔╝██║░░░░░███████║██╔██╗██║██║░░██║
#██║╚██╔╝██║██║░░██║██╔══██╗░░░░╚═══██╗  ██╔══██║░░╚██╔╝░░██╔═══╝░██╔══██╗██║░░░░░██╔══██║██║╚████║██║░░██║
#██║░╚═╝░██║╚█████╔╝██████╦╝░░░██████╔╝  ██║░░██║░░░██║░░░██║░░░░░██║░░██║███████╗██║░░██║██║░╚███║██████╔╝
#╚═╝░░░░░╚═╝░╚════╝░╚═════╝░░░░╚═════╝░  ╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░
# >> The file that binds everything together.
{
  config,
  themes,
  ...
}: {
  # Features
  # ===================================================================
  # Keybinds and mousebinds
  imports = [
    ./keys.nix
  ];

  wayland.windowManager.hyprland.settings = let
    inherit (themes.colorscheme) colors;
  in {
    # Initialization
    # ===================================================================
    input = {
      follow_mouse = 1;
      float_switch_override_focus = 0;

      touchpad = {
        natural_scroll = false;
      };

      sensitivity = 0;
    };

    general = {
      border_size = 3;
      "col.active_border" = "rgb(${colors.orange})";
      "col.inactive_border" = "rgb(${colors.lightbg2})";
      gaps_in = 5;
      gaps_out = 10;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      focus_on_activate = true;
      force_default_wallpaper = 0;
      new_window_takes_over_fullscreen = 2;
    };

    monitor = [
      "eDP-1, highres, 0x0, 1"
    ];

    # Decorations
    # ===================================================================
    animations = {
      enabled = true;

      bezier = [
        "overshot, 0.05, 0.9, 0.1, 1.05"
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
      ];

      animation = [
        "border, 1, 5, default"
        "fade, 1, 5, smoothIn"
        "fadeDim, 1, 5, smoothIn"
        "windows, 1, 5, overshot, slide"
        "windowsMove, 1, 4, smoothIn, slide"
        "windowsOut, 1, 4, smoothOut, slide"
        "workspaces, 1, 6, default"
      ];
    };

    decoration = {
      rounding = 10;

      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";

      blur = {
        enabled = true;
        passes = 1;
        size = 3;
      };
    };

    # Layouts
    # ===================================================================
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_is_master = true;
      mfact = 0.5;
      new_on_top = true;
    };

    gestures = {
      workspace_swipe = false;
    };

    # Rules
    # ===================================================================
    windowrulev2 = [
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"

      #Always float
      "float, title:^(Picture-in-Picture)$"
      "float, class:^(imv)$"
      "float, class:^(xdg-desktop-portal-gtk)$"

      # Floating and scratchpad terminal float
      "float, class:^(scratchpad)$, title:^(Alacritty)$"
      "float, class:^(floating_terminal)$, title:^(Alacritty)$"

      "pin, title:^(Picture-in-Picture)$"

      # Start application on specific workspace
      # ===================================================================
      # Browsing
      "workspace 1 silent, class:^(firefox)$"

      # Work
      "workspace 2 silent, class:^(appflowy)$"

      # Editing
      "workspace 3 silent, class:^(editor)$"

      # Games
      "workspace 4 silent, class:^(steam)$"

      # Chatting
      "workspace 5 silent, class:^(discord)$"

      # System monitoring
      "workspace 6 silent, class:^(bottom)$"
      "workspace 6 silent, class:^(pavucontrol)$"

      # Mail
      "workspace 7 silent, class:^(email)$"

      # Miscellaneous
      # All clients that I want out of my way when they are running
      "workspace 10 silent, class:^(qemu)$"
    ];
  };
}
