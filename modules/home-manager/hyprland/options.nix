#███╗░░░███╗░█████╗░██████╗░██╗░██████╗  ██╗░░██╗██╗░░░██╗██████╗░██████╗░██╗░░░░░░█████╗░███╗░░██╗██████╗░
#████╗░████║██╔══██╗██╔══██╗╚█║██╔════╝  ██║░░██║╚██╗░██╔╝██╔══██╗██╔══██╗██║░░░░░██╔══██╗████╗░██║██╔══██╗
#██╔████╔██║██║░░██║██████╦╝░╚╝╚█████╗░  ███████║░╚████╔╝░██████╔╝██████╔╝██║░░░░░███████║██╔██╗██║██║░░██║
#██║╚██╔╝██║██║░░██║██╔══██╗░░░░╚═══██╗  ██╔══██║░░╚██╔╝░░██╔═══╝░██╔══██╗██║░░░░░██╔══██║██║╚████║██║░░██║
#██║░╚═╝░██║╚█████╔╝██████╦╝░░░██████╔╝  ██║░░██║░░░██║░░░██║░░░░░██║░░██║███████╗██║░░██║██║░╚███║██████╔╝
#╚═╝░░░░░╚═╝░╚════╝░╚═════╝░░░░╚═════╝░  ╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░
# >> The file that binds everything together.
{
  config,
  lib,
  pkgs,
  ...
}: let
  _ = lib.getExe;

  # Volume control utility
  volumectl = let
    inherit (pkgs) libnotify pamixer libcanberra-gtk3;
  in
    pkgs.writeShellScriptBin "volumectl" ''
      #!/usr/bin/env bash

      case "$1" in
      up)
        ${_ pamixer} -i "$2"
        ;;
      down)
        ${_ pamixer} -d "$2"
        ;;
      toggle-mute)
        ${_ pamixer} -t
        ;;
      esac

      volume_percentage="$(${_ pamixer} --get-volume)"
      isMuted="$(${_ pamixer} --get-mute)"

      if [ "$isMuted" = "true" ]; then
        ${libnotify}/bin/notify-send --transient \
          -u normal \
          -a "VOLUMECTL" \
          -i audio-volume-muted-symbolic \
          "VOLUMECTL" "Volume Muted"
      else
        ${libnotify}/bin/notify-send --transient \
          -u normal \
          -a "VOLUMECTL" \
          -h string:x-canonical-private-synchronous:volumectl \
          -h int:value:"$volume_percentage" \
          -i audio-volume-high-symbolic \
          "VOLUMECTL" "Volume: $volume_percentage%"

        ${libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
      fi
    '';

  # Brightness control utility
  lightctl = let
    inherit (pkgs) libnotify brightnessctl;
  in
    pkgs.writeShellScriptBin "lightctl" ''
      case "$1" in
      up)
        ${_ brightnessctl} -q s +"$2"%
        ;;
      down)
        ${_ brightnessctl} -q s "$2"%-
        ;;
      esac

      brightness_percentage=$((($(${_ brightnessctl} g) * 100) / $(${_ brightnessctl} m)))
      ${libnotify}/bin/notify-send --transient \
        -u normal \
        -a "LIGHTCTL" \
        -h string:x-canonical-private-synchronous:lightctl \
        -h int:value:"$brightness_percentage" \
        -i display-brightness-symbolic \
        "LIGHTCTL" "Brightness: $brightness_percentage%"
    '';
in {
  options = {
    myhome.hyprland.options.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.myhome.hyprland.options.enable {
    home.packages = with pkgs; [
      grim
      libnotify
      pcmanfm
      slurp
      swappy
      swaynotificationcenter
      wl-clipboard
      xdg-utils

      lightctl
      volumectl
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      settings = with config.myhome.colorscheme; {
        # Initialization
        # ===================================================================
        general = {
          border_size = 2;
          "col.active_border" = "rgb(${colors.white})";
          "col.inactive_border" = "rgb(${colors.light-black})";
          gaps_in = 4;
          gaps_out = 8;
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
          rounding = 8;

          drop_shadow = true;
          shadow_offset = "0 2";
          shadow_range = 20;
          shadow_render_power = 3;
          "col.shadow" = "rgba(00000055)";

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

          # Floating terminal float
          "float, class:^(floating_terminal)$, title:^(Alacritty)$"

          # Pin windows on top
          "pin, title:^(Picture-in-Picture)$"

          # Start application on specific workspace
          # ===================================================================
          # Browsing
          "workspace 1 silent, class:^(firefox)$"
          "workspace r silent, class:^(firefox)$, title:^(.*Upload*.)$"

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

      systemd = {
        enable = true;
        extraCommands = lib.mkBefore [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };

    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = ["graphical-session-pre.target"];
      };
    };

    xdg = {
      enable = true;
      cacheHome = config.home.homeDirectory + "/.local/cache";
      mimeApps.enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
