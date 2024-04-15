{
  imports = [./hardware-configuration.nix];

  # Nixos modules
  # ===================================================================
  mynixos = {
    base.enable = true;

    hyprland.enable = true;
  };

  networking.hostName = "hana";
}
