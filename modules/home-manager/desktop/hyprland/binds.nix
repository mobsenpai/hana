{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf optionals getExe getExe';
  inherit (osConfig.modules.system) device;
  inherit (config.modules.desktop) windowManager;
  osDesktopEnabled = osConfig.modules.system.desktop.enable;

  jaq = getExe pkgs.jaq;
  hyprctl = getExe' config.wayland.windowManager.hyprland.package "hyprctl";
  brightnessctl = getExe pkgs.brightnessctl;
  yad = getExe pkgs.yad;

  toggleFloating =
    pkgs.writeShellScript "hypr-toggle-floating"
    /*
    bash
    */
    ''
      if [[ $(${hyprctl} activewindow -j | ${jaq} -r '.floating') == "false" ]]; then
        ${hyprctl} --batch 'dispatch togglefloating; dispatch resizeactive exact 75% 75%; dispatch centerwindow;'
      else
        ${hyprctl} dispatch togglefloating
      fi
    '';

  kbmenu =
    pkgs.writeShellScript "kbmenu"
    /*
    bash
    */
    ''
      if pidof wofi >/dev/null; then
        pkill wofi
      fi

      ${yad} \
        --center \
        --title="Hyprland Keybinds" \
        --no-buttons \
        --list \
        --width=500 \
        --height=600 \
        --column=Key: \
        --column=Description: \
        --timeout-indicator=bottom \
        "SUPER Return" "Launch terminal" \
        "SUPER SHIFT Return" "Launch floating terminal" \
        "SUPER A" "Launch wofi" \
        "SUPER F2" "Launch browser" \
        "SUPER F3" "Launch file manager" \
        "SUPER F4" "Launch Appflowy" \
        "SUPER CTRL C" "Colour picker" \
        "SUPER, Left Click" "Move window with mouse" \
        "SUPER, Right Click" "Resize window with mouse" \
        "SUPER SHIFT →" "Resize window right" \
        "SUPER SHIFT ←" "Resize window left" \
        "SUPER SHIFT ↑" "Resize window up" \
        "SUPER SHIFT ↓" "Resize window down" \
        "SUPER SHIFT L" "Resize window right (HJKL)" \
        "SUPER SHIFT H" "Resize window left (HJKL)" \
        "SUPER SHIFT K" "Resize window up (HJKL)" \
        "SUPER SHIFT J" "Resize window down (HJKL)" \
        "XF86MonBrightnessDown" "Decrease brightness" \
        "XF86MonBrightnessUp" "Increase brightness" \
        "XF86AudioLowerVolume" "Lower volume" \
        "XF86AudioRaiseVolume" "Increase volume" \
        "XF86AudioMicMute" "Mute microphone" \
        "XF86AudioMute" "Mute audio" \
        "XF86AudioPlay" "Play/Pause media" \
        "XF86AudioNext" "Next media track" \
        "XF86AudioPrev" "Previous media track" \
        "SUPER SHIFT Q" "Exit Hyprland session" \
        "SUPER CTRL SPACE" "Toggle floating window" \
        "SUPER F" "Toggle fullscreen" \
        "SUPER ALT Period(.)" "Lock screen" \
        "SUPER U" "Toggle Hypridle service" \
        "SUPER Q" "Close active window" \
        "SUPER E" "Launch emoji picker" \
        "Prtscrn" "Screenshot (clipboard)" \
        "Shift Prtscrn" "Screenshot (save)" \
        "SUPER SHIFT CTRL ←" "Move window left" \
        "SUPER SHIFT CTRL →" "Move window right" \
        "SUPER SHIFT CTRL ↑" "Move window up" \
        "SUPER SHIFT CTRL ↓" "Move window down" \
        "SUPER SHIFT S" "Move to scratchpad" \
        "SUPER S" "Toggle scratchpad workspace" \
        "ALT Tab" "Cycle next window" \
        "SUPER CTRL →" "Switch to next workspace" \
        "SUPER CTRL ←" "Switch to previous workspace" \
        "SUPER CTRL ↓" "Go to first empty workspace" \
        "SUPER ←" "Move focus left" \
        "SUPER →" "Move focus right" \
        "SUPER ↑" "Move focus up" \
        "SUPER ↓" "Move focus down" \
        "SUPER 1-0" "Switch to workspace 1-10" \
        "SUPER SHIFT 1-0" "Move to workspace 1-10" \
        "SUPER SHIFT 1-0" "Silently move to workspace 1-10"
    '';
in
  mkIf (osDesktopEnabled && windowManager == "Hyprland")
  {
    wayland.windowManager.hyprland = let
      grimblast = getExe pkgs.grimblast;
      picker = getExe pkgs.hyprpicker;
      pkill = getExe' pkgs.procps "pkill";
    in {
      settings.bind = [
        # General
        "SUPER SHIFT, Q, exit"
        "SUPER, Q, killactive"
        "SUPER, C, centerwindow, 1"
        "SUPER, F, fullscreen, 0"
        "SUPER, M, fullscreen, 1"
        "SUPER CTRL, SPACE, exec, ${toggleFloating}"

        # Focus client by direction (arrow keys)
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        # Focus client by direction (hjkl keys)
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        # Switch clients
        "ALT, TAB, cyclenext, 1"
        "ALT, TAB, alterzorder, top"
        "ALT SHIFT, TAB, cyclenext, prev"
        "ALT SHIFT, TAB, alterzorder, top"

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

        # Switch workspaces
        "SUPER, TAB, workspace, m+1"
        "SUPER SHIFT, TAB, workspace, m-1"

        # Scratchpad
        "SUPER, S, togglespecialworkspace, s1"
        "SUPER SHIFT, S, movetoworkspacesilent, special:s1"

        # Screenshots
        ", Print, exec, ${grimblast} --notify --freeze copy area"
        "SHIFT, Print, exec, ${grimblast} --notify --freeze save area"

        # Keyboard shortcuts (yad)
        "SUPER, F1, exec, ${pkill} yad || ${kbmenu}"

        # Color picker
        "SUPER CTRL, C, exec, ${picker} --autocopy --format=hex"
      ];

      # Brightness control
      settings.bindl = optionals (device.type == "laptop") [
        ", XF86MonBrightnessUp, exec, ${brightnessctl} set +5%"
        ", XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
      ];

      settings.bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      settings.binde = [
        "SUPER CTRL, H, resizeactive, -25 0"
        "SUPER CTRL, L, resizeactive, 25 0"
        "SUPER CTRL, K, resizeactive, 0 -25"
        "SUPER CTRL, J, resizeactive, 0 25"
      ];
    };
  }
