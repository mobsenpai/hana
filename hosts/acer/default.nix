{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  disabledModules = [
    # Disable the default Awesome WM module
    "services/x11/window-managers/awesome.nix"
  ];

  imports = [
    # Shared configuration across all machines
    ../shared
    ../shared/users/yashraj.nix

    # Specific configuration
    ./hardware-configuration.nix
    ./nvidia.nix
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
      # "i8042.direct"
      # "i8042.dumbkbd"
      # "i915.force_probe=46a6"
    ];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        gfxmodeEfi = "1366x768";
      };
    };
  };

  networking = {
    hostName = "acer";
    networkmanager.enable = true;
    useDHCP = false;
  };

  services = {
    # xserver = {
    #   enable = true;
    #   displayManager = {
    #     defaultSession = "none+awesome";
    #     lightdm.enable = true;
    #   };

    #   dpi = 96;

    #   # xkbOptions = "caps:escape";
    #   exportConfiguration = true;

    #   windowManager = {
    #     awesome = {
    #       enable = true;
    #       package = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
    #       luaModules = lib.attrValues {
    #         inherit (pkgs.luaPackages) lgi;
    #       };
    #     };
    #   };
    # };

    # btrfs.autoScrub.enable = true;
    acpid.enable = true;
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
        # libva-utils
        
        ntfs3g
        ;

      inherit
        (pkgs.libsForQt5)
        qtstyleplugins
        ;
    };

    variables = {
      # GDK_SCALE = "2";
      # GDK_DPI_SCALE = "0.5";
      QT_QPA_PLATFORMTHEME = "gtk2";
      CM_LAUNCHER = "rofi";
    };
  };

  # Use custom Awesome WM module
  services.xserver.windowManager.awesome.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
