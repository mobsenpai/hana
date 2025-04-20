{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit
    (lib)
    mkIf
    optionals
    optional
    getExe
    getExe'
    ;
  inherit (osConfig.modules.system) audio;
  desktopCfg = config.modules.desktop;
  osDesktopEnabled = osConfig.modules.system.desktop.enable;
  isLaptop = osConfig.modules.system.device.type == "laptop";

  jaq = getExe pkgs.jaq;
  hyprctl = getExe' config.wayland.windowManager.hyprland.package "hyprctl";

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
in
  mkIf (osDesktopEnabled && desktopCfg.windowManager == "Hyprland")
  {
    wayland.windowManager.hyprland = let
      brightnessctl = getExe pkgs.brightnessctl;
      grimblast = getExe pkgs.grimblast;
      playerctl = getExe pkgs.playerctl;
      wpctl = getExe' pkgs.wireplumber "wpctl";
    in {
      settings.bind =
        [
          # General
          "SUPER SHIFT, Q, exit"
          "SUPER, Q, killactive"
          "SUPER, C, centerwindow, 1"
          "SUPER, F, fullscreen, 0"
          "SUPER, M, fullscreen, 1"
          "SUPER CTRL, SPACE, exec, ${toggleFloating}"

          # Screenshots
          ", Print, exec, ${grimblast} --notify --freeze copy area"
          "SHIFT, Print, exec, ${grimblast} --notify --freeze save area"

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
        ]
        ++ optional audio.enable ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ++ optionals isLaptop [
          ", XF86MonBrightnessUp, exec, ${brightnessctl} set +5%"
          ", XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
        ];

      settings.bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      settings.binde =
        optionals audio.enable
        [
          ", XF86AudioNext,exec, ${playerctl} next"
          ", XF86AudioPrev,exec, ${playerctl} previous"
          ", XF86AudioPlay,exec, ${playerctl} play-pause"
          ", XF86AudioStop,exec, ${playerctl} stop"

          "SUPER CTRL, H, resizeactive, -25 0"
          "SUPER CTRL, L, resizeactive, 25 0"
          "SUPER CTRL, K, resizeactive, 0 -25"
          "SUPER CTRL, J, resizeactive, 0 25"
        ]
        ++ optionals audio.enable [
          ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];
    };
  }
