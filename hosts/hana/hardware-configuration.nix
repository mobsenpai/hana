{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: let
  inherit (lib) mkDefault;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  services.xserver.videoDrivers = ["modesetting"];
  hardware.nvidia = {
    modesetting.enable = true;
    dynamicBoost.enable = true;
    powerManagement.finegrained = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  services.supergfxd.enable = true;
  programs.rog-control-center = {
    enable = true;
    # https://github.com/YaLTeR/niri/issues/3177
    # https://github.com/nixos/nixpkgs/issues/455932
    autoStart = true;
  };

  services.hardware.openrgb.enable = true;

  services.fwupd.enable = true;
  systemd.timers."fwupd-refresh".enable = false;

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = false;

  boot = {
    blacklistedKernelModules = ["spd5118"];
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "thunderbolt"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = ["kvm-intel" "asus_armoury"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-label/swap";}
  ];

  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
}
