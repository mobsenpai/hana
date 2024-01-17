{inputs, ...}: {
  imports = [
    ./shared

    ./shared/optional/desktop/hyprland
    ./shared/optional/programs/alacritty.nix
    ./shared/optional/programs/firefox.nix
    ./shared/optional/programs/helix.nix
  ];
}
