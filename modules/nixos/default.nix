{
  flake.nixosModules = {
    base = {
      imports = [
        ./config
        ./programs
        ./services
      ];
    };

    bluetooth = import ./hardware/bluetooth.nix;
    hyprland = import ./wm/hyprland.nix;
  };
}
