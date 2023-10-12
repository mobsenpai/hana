{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  disabledModules = [
    # TODO: Disable the default modules
    # Only use the configuration provided in modules/...
    # "services/x11/window-managers/awesome.nix"
    # "programs/hyprland.nix"
  ];

  imports = [
    # Shared configuration across all machines
    ../shared
    ../shared/users/yashraj.nix

    # Specific configuration
    ./hardware-configuration.nix
    # TODO: add gpu configuration
    # ./gpu.nix | nvidia, amd, etc
  ];

  boot = {
    initrd = {
      supportedFilesystems = ["btrfs"];
      systemd.enable = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };
  };

  networking = {
    hostName = "acer";
    networkmanager.enable = true;
    useDHCP = false;
  };

  services = {
    xserver = {
      enable = true;
      exportConfiguration = true;
      dpi = 96;

      displayManager = {
        sddm.enable = true;
      };
    };
  };

  hardware = {
    enableRedistributableFirmware = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # TODO: bluetooth enable (if supported)
    # bluetooth = {
    #   enable = true;
    #   package = pkgs.bluez;
    # };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    # TODO: required for screen sharing in wayland
    wlr.enable = true;
  };

  # Fix for qt6 plugins
  # TODO: maybe upstream this?
  # environment.profileRelativeSessionVariables = {
  #   QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
  # };

  # Use custom modules
  services.xserver.windowManager.awesome.enable = true;
  programs.hyprland.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
