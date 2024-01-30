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
    hyprland = import ./services/wayland/wm/hyprland.nix;
  };
}
