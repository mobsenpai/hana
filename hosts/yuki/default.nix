{
  inputs,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
  };

  networking.hostName = "hp";
}
