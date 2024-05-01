{
  imports = [./hardware-configuration.nix];

  myNixos = {
    base.enable = true;
    general-desktop.enable = true;
    laptop.enable = true;

    hyprland.enable = true;
  };

  networking.hostName = "hana";
}
