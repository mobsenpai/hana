{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (config.modules.desktop) windowManager;
  osDesktop = osConfig.modules.system.desktop;
in
  mkIf (osDesktop.enable && windowManager == "Niri") {
    programs.niri.settings.binds = with config.lib.niri.actions; let
      brightnessctl = getExe pkgs.brightnessctl;
    in {
      # General - main
      "Mod+Shift+Q".action = quit;
      "Mod+Q".action = close-window;
      "Mod+C".action = center-visible-columns;
      "Mod+F".action = fullscreen-window;
      "Mod+M".action = maximize-column;
      "Mod+Space".action = toggle-window-floating;

      # General - extras
      "Mod+W".action = toggle-column-tabbed-display;
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      # Resize
      "Mod+Shift+F".action = expand-column-to-available-width;
      "Mod+S".action = switch-preset-column-width;
      "Mod+Ctrl+H".action = set-column-width "-10%";
      "Mod+Ctrl+J".action = set-window-height "+10%";
      "Mod+Ctrl+K".action = set-window-height "-10%";
      "Mod+Ctrl+L".action = set-column-width "+10%";

      # Focus by direction (arrow keys)
      "Mod+Left".action = focus-column-or-monitor-left;
      "Mod+Down".action = focus-window-or-workspace-down;
      "Mod+Up".action = focus-window-or-workspace-up;
      "Mod+Right".action = focus-column-or-monitor-right;

      # Focus by direction (hjkl keys)
      "Mod+H".action = focus-column-or-monitor-left;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+L".action = focus-column-or-monitor-right;

      # Switch float-tile
      "Alt+Tab".action = switch-focus-between-floating-and-tiling;

      # Move (arrow keys)
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
      "Mod+Shift+Right".action = move-column-right;

      # Move (hjkl keys)
      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
      "Mod+Shift+L".action = move-column-right;

      # Switch workspaces with mod + [0-9]
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      "Mod+0".action = focus-workspace 10;

      # Move to a workspace with mod + SHIFT + [0-9]
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;
      "Mod+Shift+0".action.move-column-to-workspace = 10;

      # Focus monitors (arrow keys)
      "Mod+Alt+Left".action = focus-monitor-left;
      "Mod+Alt+Down".action = focus-monitor-down;
      "Mod+Alt+Up".action = focus-monitor-up;
      "Mod+Alt+Right".action = focus-monitor-right;

      # Focus monitors (hjkl keys)
      "Mod+Alt+H".action = focus-monitor-left;
      "Mod+Alt+J".action = focus-monitor-down;
      "Mod+Alt+K".action = focus-monitor-up;
      "Mod+Alt+L".action = focus-monitor-right;

      # Move to a monitor (arrow keys)
      "Mod+Shift+Alt+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Alt+Down".action = move-column-to-monitor-down;
      "Mod+Shift+Alt+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Alt+Right".action = move-column-to-monitor-right;

      # Move to a monitor (hjkl keys)
      "Mod+Shift+Alt+H".action = move-column-to-monitor-left;
      "Mod+Shift+Alt+J".action = move-column-to-monitor-down;
      "Mod+Shift+Alt+K".action = move-column-to-monitor-up;
      "Mod+Shift+Alt+L".action = move-column-to-monitor-right;

      # Switch workspaces
      "Mod+Tab".action = move-workspace-up;
      "Mod+Shift+Tab".action = move-workspace-down;

      # Screenshots
      "Print".action.screenshot-screen = {write-to-disk = true;};
      "Mod+Shift+Alt+S".action.screenshot-window = {write-to-disk = true;};
      "Mod+Shift+S".action.screenshot = {show-pointer = false;};

      # Hotkeys & overview
      "Mod+F1".action = show-hotkey-overlay;
      "Mod+D" = {
        repeat = false;
        action = toggle-overview;
      };

      # Brightness control
      "XF86MonBrightnessUp".action = spawn brightnessctl "set" "5%+";
      "XF86MonBrightnessDown".action = spawn brightnessctl "set" "5%-";
    };
  }
