{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Shared configuration
    ../shared
    ../shared/programs/alacritty.nix
    ../shared/programs/vivaldi.nix
    ../shared/programs/vscode.nix
    ../shared/programs/nvim.nix
    ../shared/programs/neofetch.nix

    # Specific configuration
    ./desktop/wm/awesome
  ];
}
