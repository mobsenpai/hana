#██╗░░██╗███████╗██╗░░░██╗██████╗░██╗███╗░░██╗██████╗░░██████╗
#██║░██╔╝██╔════╝╚██╗░██╔╝██╔══██╗██║████╗░██║██╔══██╗██╔════╝
#█████═╝░█████╗░░░╚████╔╝░██████╦╝██║██╔██╗██║██║░░██║╚█████╗░
#██╔═██╗░██╔══╝░░░░╚██╔╝░░██╔══██╗██║██║╚████║██║░░██║░╚═══██╗
#██║░╚██╗███████╗░░░██║░░░██████╦╝██║██║░╚███║██████╔╝██████╔╝
#╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═════╝░╚═╝╚═╝░░╚══╝╚═════╝░╚═════╝░
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  # User
  # ===================================================================
  gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
  xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
  defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";

  terminal = config.home.sessionVariables.TERMINAL;
  floating_terminal = "${terminal} --class floating_terminal";
  editor = "${terminal} --class editor -e ${defaultApp "text/plain"}";
  browser = defaultApp "x-scheme-handler/https";
  file_manager = "${pkgs.pcmanfm}/bin/pcmanfm";
  app_launcher = "${pkgs.wofi}/bin/wofi --show drun";

  # Features
  # ===================================================================
  # Apps
  volume = "${pkgs.pavucontrol}/bin/pavucontrol";
  screenshot = ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -'';
  screenshot_clipboard = ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png'';
  emoji_picker = "${pkgs.wofi-emoji}/bin/wofi-emoji";
  process_monitor = "${terminal} --class process_monitor -e ${pkgs.bottom}/bin/btm";
  clipboard = "${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi --dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy";
  lockscreen = "${lib.getExe inputs.hyprlock.packages.${pkgs.system}.default}";
in {
  options = {
    myhome.hyprland.keys.enable = lib.mkEnableOption "enables keys";
  };

  config = lib.mkIf config.myhome.hyprland.keys.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          # Global
          # ===================================================================
          "SUPER, Q, killactive"
          "SUPER SHIFT, Q, exit"
          # Screenshot
          ", Print, exec, ${screenshot}"
          "SHIFT, Print, exec, ${screenshot_clipboard}"
          # Clipboard
          "SUPER, V, exec, ${clipboard}"
          # Lockscreen
          "SUPER ALT, L, exec, ${lockscreen}"

          # Launchers
          # ===================================================================
          "SUPER, RETURN, exec, ${terminal}"
          "SUPER SHIFT, RETURN, exec, ${floating_terminal}"
          "SUPER, A, exec, ${app_launcher}"
          "SUPER, E, exec, ${emoji_picker}"

          # Run or raise
          "SUPER, F2, exec, pgrep ${browser} hyprctl dispatch focuswindow ${browser} || ${browser}"
          "SUPER , F2, exec, pidof -s ${browser} && hyprctl dispatch focuswindow pid:$(pidof -s ${browser}) || ${browser}"
          "SUPER, F3, exec, [float] pidof -s ${file_manager} && hyprctl dispatch focuswindow pid:$(pidof -s ${file_manager}) || ${file_manager}"
          "SUPER, F5, exec, pidof -s editor && hyprctl dispatch focuswindow pid:$(pidof -s editor) || ${editor}"
          "SUPER, F11, exec, pidof -s ${volume} && hyprctl dispatch focuswindow pid:$(pidof -s ${volume}) || ${volume}"
          "SUPER, F12, exec, pidof -s process_monitor && hyprctl dispatch focuswindow pid:$(pidof -s process_monitor) || ${process_monitor}"

          # Client manipulation
          # ===================================================================
          "SUPER CTRL, H, resizeactive, -25 0"
          "SUPER CTRL, L, resizeactive, 25 0"
          "SUPER CTRL, K, resizeactive, 0 -25"
          "SUPER CTRL, J, resizeactive, 0 25"
          "SUPER, C, centerwindow, 1"
          "SUPER, F, fullscreen, 0"
          "SUPER, M, fullscreen, 1"

          # Layout
          # ===================================================================
          "SUPER CTRL, SPACE, togglefloating"
          "ALT, TAB, cyclenext, 1"

          # Move focus with mod + arrow keys
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          # Move focus with mod + vim keys
          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, K, movefocus, u"
          "SUPER, J, movefocus, d"

          # Make focused windows come to top
          "SUPER, left, alterzorder, top"
          "SUPER, right, alterzorder, top"
          "SUPER, up, alterzorder, top"
          "SUPER, down, alterzorder, top"
          "SUPER, H, alterzorder, top"
          "SUPER, L, alterzorder, top"
          "SUPER, K, alterzorder, top"
          "SUPER, J, alterzorder, top"

          # Move window with mod + arrow keys
          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, right, movewindow, r"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, down, movewindow, d"

          # Move window with mod + vim keys
          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, L, movewindow, r"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, J, movewindow, d"

          # Switch workspaces with mod + [0-9]
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          # Move active window to a workspace with mod + SHIFT + [0-9]
          "SUPER SHIFT, 1, movetoworkspacesilent, 1"
          "SUPER SHIFT, 2, movetoworkspacesilent, 2"
          "SUPER SHIFT, 3, movetoworkspacesilent, 3"
          "SUPER SHIFT, 4, movetoworkspacesilent, 4"
          "SUPER SHIFT, 5, movetoworkspacesilent, 5"
          "SUPER SHIFT, 6, movetoworkspacesilent, 6"
          "SUPER SHIFT, 7, movetoworkspacesilent, 7"
          "SUPER SHIFT, 8, movetoworkspacesilent, 8"
          "SUPER SHIFT, 9, movetoworkspacesilent, 9"
          "SUPER SHIFT, 0, movetoworkspacesilent, 10"
        ];
        binde = [
          # Volume control
          ",XF86AudioRaiseVolume, exec, volumectl up 5"
          ",XF86AudioLowerVolume, exec, volumectl down 5"
          ",XF86AudioMute, exec, volumectl toggle-mute"

          # Media control
          ", XF86AudioNext,exec, ${pkgs.playerctl}/bin/playerctl next"
          ", XF86AudioPrev,exec, ${pkgs.playerctl}/bin/playerctl previous"
          ", XF86AudioPlay,exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ", XF86AudioStop,exec, ${pkgs.playerctl}/bin/playerctl stop"

          # Brightness control
          ",XF86MonBrightnessUp, exec, lightctl up 5"
          ",XF86MonBrightnessDown, exec, lightctl down 5"
        ];

        # Mouse bindings
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
  };
}
