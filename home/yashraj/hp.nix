{inputs, ...}: {
  imports = [
    ./shared

    ./shared/optional/desktop/hyprland
    ./shared/optional/programs/wezterm.nix
    ./shared/optional/programs/helix.nix
    ./shared/optional/programs/vivaldi.nix
    ./shared/optional/programs/vscode.nix
  ];
}
