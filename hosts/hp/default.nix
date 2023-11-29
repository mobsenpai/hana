{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../shared
    ../shared/users/yashraj.nix

    ../shared/optional/hyprland.nix
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
