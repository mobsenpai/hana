{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvidia.nix

    # Shared configuration across all machines.
    ../shared
    ../shared/users/yashraj.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["btrfs"];
    };

    kernelParams = [
      "i915.force_probe=46a6"
      "i915.enable_psr=0"
      "i915.enable_guc=2"
      "i8042.direct"
      "i8042.dumbkbd"
    ];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      # systemd-boot.enable = true;
      systemd-boot.enable = false;

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
    networkmanager.enable = true;
    useDHCP = false;
  };

  # Windows wants hardware clock in local time instead of UTC
  time.hardwareClockInLocalTime = true;

  services = {
    xserver = {
      enable = true;

      windowManager = {
        awesome = {
          enable = true;
          # luaModules = lib.attrValues {
          #   inherit (pkgs.luaPackages) lgi;
          # };
        };
      };

      dpi = 96;

      displayManager = {
        defaultSession = "none+awesome";
        lightdm.enable = true;
      };
    };

    # btrfs.autoScrub.enable = true;
    # acpid.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver # iHD
        libva
        libvdpau
        libvdpau-va-gl
        (vaapiIntel.override {enableHybridCodec = true;}) # i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
      ];
    };

    enableRedistributableFirmware = true;
    pulseaudio.enable = false;

    # bluetooth = {
    #   enable = true;
    #   package = pkgs.bluez;
    # };
  };

  # compresses half the ram for use as swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      libsForQt5.qtstyleplugins
    ];

    variables = {};
    sessionVariables = {};
  };

  system.stateVersion = lib.mkForce "22.11"; # DONT TOUCH THIS
}
