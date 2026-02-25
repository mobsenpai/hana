{
  lib,
  pkgs,
  config,
  hostname,
  ...
}: let
  inherit (lib) utils mkIf getExe;
  inherit (config.modules.system) desktop;
  inherit (config.modules.core) homeManager;
  inherit (config.modules.system.desktop) desktopEnvironment;
  cfg = config.modules.system.networking;
in {
  assertions = utils.asserts [
    (cfg.applet.enable -> config.modules.core.homeManager.enable)
    "networking.applet requires homeManager.enable"

    (cfg.applet.enable -> desktopEnvironment == null)
    "networking.applet only for window managers"
  ];

  systemd.network = {
    enable = cfg.useNetworkd;
    wait-online.anyInterface = true;

    # The default timeout of 120 seconds is too long for devices where we want
    # to get into the desktop regardless of network connectivity.
    wait-online.timeout = mkIf desktop.enable 10;

    # Nix generates default systemd-networkd network configs which match all
    # interfaces so manually defining networks is not really necessary unless
    # custom configuration is required
  };

  networking = {
    hostName = hostname;
    useNetworkd = cfg.useNetworkd;
    firewall = {
      enable = cfg.firewall.enable;
    };

    wireless = mkIf cfg.wireless.enable {
      enable = cfg.wireless.backend == "wpa_supplicant";
      userControlled.enable = true;
      allowAuxiliaryImperativeNetworks = true;
      fallbackToWPA2 = true;

      iwd = {
        enable = cfg.wireless.backend == "iwd";
        settings = {
          General.AddressRandomization = "network";
          # https://github.com/nixos/nixpkgs/issues/454655
          DriverQuirks.DefaultInterface = "";
        };
      };
    };
  };

  hm = let
    iwgtk = getExe pkgs.iwgtk;
    wpa_gui = getExe pkgs.wpa_supplicant_gui;
  in
    mkIf homeManager.enable {
      home.packages = mkIf (cfg.wireless.enable && desktopEnvironment == null) [
        (mkIf (cfg.wireless.backend == "iwd") pkgs.iwgtk)
        (mkIf (cfg.wireless.backend == "wpa_supplicant") pkgs.wpa_supplicant_gui)
      ];

      # NOTE: if iwgtk,wpa_gui services are upstream then can be removed
      # and enable the native service option
      systemd.user.services = mkIf (cfg.applet.enable && desktopEnvironment == null) {
        iwgtk = mkIf (cfg.wireless.enable && cfg.wireless.backend == "iwd") {
          Unit = {
            Description = "iwd GTK tray applet";
          };

          Service = {
            Type = "simple";
            ExecStart = "${iwgtk} -i";
            Restart = "on-failure";
            RestartSec = 3;
          };

          Install.WantedBy = ["graphical-session.target"];
        };

        wpa-gui = mkIf (cfg.wireless.enable && cfg.wireless.backend == "wpa_supplicant") {
          Unit = {
            Description = "wpa_supplicant GTK tray applet";
          };

          Service = {
            Type = "simple";
            ExecStart = "${wpa_gui} -t";
            Restart = "on-failure";
            RestartSec = 3;
          };

          Install.WantedBy = ["graphical-session.target"];
        };
      };

      desktop.niri.settings.window-rules = [
        {
          matches = [{app-id = "org\\.twosheds\\.iwgtk";}];
          open-floating = true;
          default-column-width = {proportion = 0.6;};
          default-window-height = {proportion = 0.6;};
        }

        {
          matches = [{app-id = "wpa_gui";}];
          open-floating = true;
          default-column-width = {proportion = 0.6;};
          default-window-height = {proportion = 0.6;};
        }
      ];

      desktop.hyprland.settings.windowrule = [
        "float, class:^(org\\.twosheds\\.iwgtk)$"
        "size 60% 60%, class:^(org\\.twosheds\\.iwgtk)$"
        "center, class:^(org\\.twosheds\\.iwgtk)$"

        "float, class:^(wpa_gui)$"
        "size 60% 60%, class:^(wpa_gui)$"
        "center, class:^(wpa_gui)$"
      ];
    };
}
