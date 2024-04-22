#██╗░░██╗███████╗██╗░░░██╗██████╗░██╗███╗░░██╗██████╗░░██████╗
#██║░██╔╝██╔════╝╚██╗░██╔╝██╔══██╗██║████╗░██║██╔══██╗██╔════╝
#█████═╝░█████╗░░░╚████╔╝░██████╦╝██║██╔██╗██║██║░░██║╚█████╗░
#██╔═██╗░██╔══╝░░░░╚██╔╝░░██╔══██╗██║██║╚████║██║░░██║░╚═══██╗
#██║░╚██╗███████╗░░░██║░░░██████╦╝██║██║░╚███║██████╔╝██████╔╝
#╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═════╝░╚═╝╚═╝░░╚══╝╚═════╝░╚═════╝░
{
  config,
  lib,
  pkgs,
  ...
}: let
  # Helpers
  # ===================================================================
  gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
  xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
  defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";

  # User
  # ===================================================================
  user = {
    browser = defaultApp "x-scheme-handler/https";
    terminal = config.home.sessionVariables.TERMINAL;
    floating_terminal = "${user.terminal} --class floating_terminal";
    app_launcher = "${pkgs.wofi}/bin/wofi --show drun";
  };

  # Features
  # ===================================================================
  # Apps
  apps = {
    screenshot_full = ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -'';
    screenshot_clipboard = ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png'';
    clipboard = "${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi --dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy";
    emoji_picker = "${pkgs.wofi-emoji}/bin/wofi-emoji";
  };
in {
  options = {
    myhome.hyprland.keys.enable = lib.mkEnableOption "Enables keys";
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
          ", Print, exec, ${apps.screenshot_full}"
          "SHIFT, Print, exec, ${apps.screenshot_clipboard}"
          # Clipboard
          "SUPER, V, exec, ${apps.clipboard}"
          # Lockscreen
          "SUPER ALT, L, exec, ${pkgs.systemd}/bin/loginctl lock-session"

          # Launchers
          # ===================================================================
          "SUPER, RETURN, exec, ${user.terminal}"
          "SUPER SHIFT, RETURN, exec, ${user.floating_terminal}"
          "SUPER, A, exec, ${user.app_launcher}"
          "SUPER, E, exec, ${apps.emoji_picker}"

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
          "ALT, TAB, alterzorder, top"
          "ALT SHIFT, TAB, cyclenext, prev"
          "ALT SHIFT, TAB, alterzorder, top"

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
