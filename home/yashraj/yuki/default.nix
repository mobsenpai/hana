{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Shared configuration
    ../shared
    # ../shared/programs/kitty.nix
    ../shared/programs/nvim.nix
    ../shared/programs/vivaldi.nix
    ../shared/programs/vscode.nix
    ../shared/programs/wezterm.nix

    # Specific configuration
    ./desktop
    ./services
    ./X
  ];
}
