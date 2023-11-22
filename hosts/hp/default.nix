{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Shared configuration across all machines
    ../shared
    ../shared/users/yashraj.nix

    # Specific configuration
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  networking = {
    hostName = "hp";
    networkmanager.enable = true;
    useDHCP = false;
  };

  services = {
    xserver = {
      enable = true;

      displayManager = {
        gdm.enable = true;
      };
    };
  };

  hardware = {
    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };
  };

  programs.hyprland.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
