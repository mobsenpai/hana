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
  osDesktop = osConfig.modules.system.desktop;

  jaq = getExe pkgs.jaq;
  hyprctl = getExe' config.wayland.windowManager.hyprland.package "hyprctl";
  brightnessctl = getExe pkgs.brightnessctl;
  yad = getExe pkgs.yad;
  sort = getExe' pkgs.coreutils "sort";
  tr = getExe' pkgs.coreutils "tr";

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

  hotkeyOverlay = pkgs.writeShellScript "hotkeyOverlay" ''
    # (Super=64, Ctrl=4, Alt=8, Shift=1)
    get_mods() {
      local mask=$1
      local mods=()
      ((mask & 64))  && mods+=("SUPER")
      ((mask & 4))   && mods+=("CTRL")
      ((mask & 8))   && mods+=("ALT")
      ((mask & 1))   && mods+=("SHIFT")

      if [ ''${#mods[@]} -eq 0 ]; then
        echo ""
      else
        echo "''${mods[*]}"
      fi
    }

    # Dynamic binds from Hyprland via JSON using jaq
    dynamic_binds=$(${hyprctl} binds -j | ${jaq} -r '.[] | select(.description != "") | "\(.modmask)|\(.key)|\(.description)"' | while IFS='|' read -r mask key desc; do
      mod=$(get_mods "$mask")
      [[ -n "$mod" ]] && kbind="$mod $key" || kbind="$key"
      printf "%s|%s\n" "$kbind" "$desc"
    done)

    # Manual Binds
    manual_binds=$(cat <<EOF
    SUPER CTRL C|Colour picker
    SUPER Left Click|Move window with mouse
    SUPER Right Click|Resize window with mouse
    SUPER SHIFT HJKL|Move window (vim keys)
    SUPER SHIFT ←↓↑→|Move window (arrow keys)
    SUPER CTRL HJKL|Resize active window
    SUPER SHIFT Q|Exit hyprland
    SUPER CTRL SPACE|Toggle floating window
    SUPER F|Toggle fullscreen
    SUPER Q|Close active window
    Prtscrn|Screenshot (clipboard)
    SHIFT Prtscrn|Screenshot (save)
    SUPER SHIFT S|Move to scratchpad
    SUPER S|Toggle scratchpad workspace
    ALT Tab|Cycle next window
    ALT Shift Tab|Cycle previous window
    SUPER ←↓↑→|Focus direction (arrow keys)
    SUPER HJKL|Focus direction (vim keys)
    SUPER 1-0|Switch to workspace 1-10
    SUPER SHIFT 1-0|Move to workspace 1-10
    EOF)

    # YAD list format
    {
      echo "$dynamic_binds"
      echo "$manual_binds"
    } | ${sort} -f | ${tr} '|' '\n' | ${yad} \
        --list \
        --title="Hyprland Keybinds" \
        --width=500 --height=600 \
        --center --no-buttons \
        --column="Key" \
        --column="Description" \
        --separator=""
  '';
in
  mkIf (osDesktop.enable && windowManager == "Hyprland")
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
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"

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
        "SUPER SHIFT, J, movewindow, d"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, L, movewindow, r"

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
        "SUPER, F1, exec, ${pkill} yad || ${hotkeyOverlay}"

        # Color picker
        "SUPER CTRL, C, exec, ${picker} --autocopy --format=hex"
      ];

      # Brightness control
      settings.bindl = optionals (device.type == "laptop") [
        ", XF86MonBrightnessUp, exec, ${brightnessctl} set +5%"
        ", XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
      ];

      # Mouse
      settings.bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      # Resize
      settings.binde = [
        "SUPER CTRL, H, resizeactive, -25 0"
        "SUPER CTRL, J, resizeactive, 0 25"
        "SUPER CTRL, K, resizeactive, 0 -25"
        "SUPER CTRL, L, resizeactive, 25 0"

        "SUPER CTRL, left, resizeactive, -25 0"
        "SUPER CTRL, down, resizeactive, 0 25"
        "SUPER CTRL, up, resizeactive, 0 -25"
        "SUPER CTRL, right, resizeactive, 25 0"
      ];
    };
  }
