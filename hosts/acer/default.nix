{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  disabledModules = [
    # Disable the default modules
    # "services/x11/window-managers/awesome.nix"
    # "programs/hyprland.nix"
  ];

  imports = [
    # Shared configuration across all machines
    ../shared
    ../shared/users/yashraj.nix

    # Specific configuration
    ./hardware-configuration.nix
  ];

  boot = {
    initrd = {
      supportedFilesystems = ["btrfs"];
      systemd.enable = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    kernelModules = ["acpi_call"];
    kernelParams = [
      "i8042.direct"
      "i8042.dumbkbd"
      "i915.force_probe=46a6"
    ];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot.enable = true;
    };
  };

  networking = {
    hostName = "acer";
    networkmanager.enable = true;
    useDHCP = false;
  };

  services = {
    acpid.enable = true;
    btrfs.autoScrub.enable = true;

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
  };

  environment = {
    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        acpi
        libva
        libvdpau
        libva-utils
        ;

      inherit
        (pkgs.libsForQt5)
        qtstyleplugins
        ;
    };

    variables = {
      QT_QPA_PLATFORMTHEME = "gtk2";
    };
  };

  # Use custom modules
  services.xserver.windowManager.awesome.enable = true;
  programs.hyprland.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
