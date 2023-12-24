{inputs, ...}: {
  imports = [
    ./shared

    ./shared/optional/desktop/hyprland
    ./shared/optional/programs/firefox.nix
    ./shared/optional/programs/helix.nix
    ./shared/optional/programs/vscode.nix
    ./shared/optional/programs/wezterm.nix
  ];
}
