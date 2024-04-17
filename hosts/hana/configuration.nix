{
  imports = [./hardware-configuration.nix];

  mynixos = {
    base.enable = true;
    general-desktop.enable = true;

    hyprland.enable = true;
  };

  networking.hostName = "hana";
}
