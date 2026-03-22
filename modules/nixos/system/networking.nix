{
  lib,
  pkgs,
  config,
  hostname,
  ...
}: let
  inherit (lib) utils mkIf getExe optionals;
  inherit (config.modules.system) desktop;
  inherit (config.modules.core) homeManager;
  inherit (config.modules.system.desktop) desktopEnvironment;
  inherit (config.modules.system) device;
  cfg = config.modules.system.networking;
in {
  assertions = utils.asserts [
    (cfg.applet.enable -> config.modules.core.homeManager.enable)
    "networking.applet requires homeManager.enable"

    (cfg.applet.enable -> desktopEnvironment == null)
    "networking.applet only for window managers"
  ];

  systemd.network = mkIf cfg.useNetworkd {
    enable = true;
    wait-online.anyInterface = true;
    wait-online.timeout = mkIf desktop.enable 10;
    networks = {
      "10-wired" = mkIf (cfg.wiredInterface != null) {
        matchConfig.Name = cfg.wiredInterface;
        networkConfig = {
          DHCP = cfg.staticIPAddress == null;
          Address = mkIf (cfg.staticIPAddress != null) cfg.staticIPAddress;
          Gateway = mkIf (cfg.staticIPAddress != null) cfg.defaultGateway;
        };

        dhcpV4Config.ClientIdentifier = "mac";
      };

      "10-wireless" = mkIf cfg.wireless.enable {
        matchConfig.Name = cfg.wireless.interface;
        networkConfig.DHCP = true;
        dhcpV4Config.RouteMetric = 1025;
      };
    };
  };

  networking = {
    hostName = hostname;
    useNetworkd = cfg.useNetworkd;
    firewall = {
      enable = cfg.firewall.enable;
      allowedTCPPorts = [] ++ optionals (config.hm.services.syncthing.enable) [22000];
      allowedUDPPorts = [] ++ optionals (config.hm.services.syncthing.enable) [22000 21027];
    };

    wireless = mkIf cfg.wireless.enable {
      enable = cfg.wireless.backend == "wpa_supplicant";
      userControlled.enable = true;
      scanOnLowSignal = device.type == "laptop";
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

  services.resolved.enable = cfg.resolved.enable;
  systemd.services.disable-wifi-powersave = mkIf (cfg.wireless.enable && !cfg.wireless.powersave) {
    description = "Disable wifi powersave";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${getExe pkgs.iw} dev ${cfg.wireless.interface} set power_save off";
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
          Unit.Description = "iwd GTK tray applet";
          Service = {
            Type = "simple";
            ExecStart = "${iwgtk} -i";
            Restart = "on-failure";
            RestartSec = 3;
          };

          Install.WantedBy = ["graphical-session.target"];
        };

        wpa-gui = mkIf (cfg.wireless.enable && cfg.wireless.backend == "wpa_supplicant") {
          Unit.Description = "wpa_supplicant GTK tray applet";
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
