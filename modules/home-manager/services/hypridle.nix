{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf mkForce utils getExe getExe' optional;
  inherit (config.modules.desktop) windowManager;
  cfg = config.modules.services.hypridle;
in
  mkIf cfg.enable
  {
    assertions = utils.asserts [
      (config.programs.hyprlock.enable)
      "Hyidle requires hyprlock to be enabled"
    ];

    services.hypridle = {
      enable = true;
      settings = let
        loginctl = getExe' pkgs.systemd "loginctl";
        hyprlock = getExe config.programs.hyprlock.package;
        hyprctl = getExe' config.wayland.windowManager.hyprland.package "hyprctl";
        niri = getExe' config.programs.niri.package "niri";
        systemctl = getExe' pkgs.systemd "systemctl";
        pidof = getExe' pkgs.procps "pidof";
        notifySend = getExe pkgs.libnotify;
        wpctl = getExe' pkgs.wireplumber "wpctl";
        isAudioPlaying = pkgs.writeShellScript "is-audio-playing" ''
          ${wpctl} status | grep -A 10 "Streams" | grep -q "active"
        '';
      in {
        general = {
          ignore_dbus_inhibit = mkIf (windowManager == "Niri") true;
          after_sleep_cmd =
            if windowManager == "Hyprland"
            then "${hyprctl} dispatch dpms on"
            else if windowManager == "Niri"
            then "${niri} msg action power-on-monitors"
            else null;

          before_sleep_cmd = "${loginctl} lock-session";
          lock_cmd = "${pidof} hyprlock || ${hyprlock}";
        };

        listener =
          [
            {
              timeout = 290;
              on-timeout = "${notifySend} --urgency=normal -t 10000 'Locking screen in 10 seconds'";
            }

            {
              timeout = 300;
              on-timeout = "${loginctl} lock-session";
            }
          ]
          ++ optional (windowManager == "Hyprland") {
            timeout = 330;
            on-timeout = "${hyprctl} dispatch dpms off";
            on-resume = "${hyprctl} dispatch dpms on";
          }
          ++ optional (windowManager == "Niri") {
            timeout = 330;
            on-timeout = "${niri} msg action power-off-monitors";
            on-resume = "${niri} msg action power-on-monitors";
          }
          ++ [
            {
              timeout = 600;
              on-timeout = "${isAudioPlaying} || ${systemctl} suspend";
            }
          ];
      };
    };

    systemd.user.services.hypridle = {
      Unit = {
        After = mkForce ["graphical-session.target"];
        Requisite = ["graphical-session.target"];
      };

      Service =
        {
          Slice = "background${utils.sliceSuffix osConfig}.slice";
        }
        // lib.optionalAttrs (! (config.services.hypridle.settings.general.ignore_dbus_inhibit or false)) {
          Type = "dbus";
          BusName = "org.freedesktop.ScreenSaver";
        };
    };

    desktop = let
      systemctl = getExe' pkgs.systemd "systemctl";
      notifySend = getExe pkgs.libnotify;
      toggleHypridle = pkgs.writeShellScript "hypridle-toggle" ''
        ${systemctl} is-active --quiet --user hypridle && {
          ${systemctl} stop --quiet --user hypridle
          ${notifySend} --urgency=low -t 2000 'Hypridle' 'Service disabled'
        } || {
          ${systemctl} start --quiet --user hypridle
          ${notifySend} --urgency=low -t 2000 'Hypridle' 'Service enabled'
        }
      '';
    in {
      niri.binds = with config.lib.niri.actions; {
        "Mod+U" = {
          action = spawn "${toggleHypridle}";
          hotkey-overlay.title = "Toggle hypridle";
        };
      };

      hyprland.binds = [
        "SUPER, U,  Toggle hypridle, exec, ${toggleHypridle}"
      ];
    };
  }
