{
  lib,
  config,
  hostname,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.modules.system) desktop;
  cfg = config.modules.system.networking;
in {
  systemd.network = {
    enable = true;
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
    useNetworkd = true;
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
}
