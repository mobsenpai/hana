{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home.nix
    ./packages.nix

    ./modules/colorschemes
    ./modules/shell
    ./modules/desktop/wm/awesome
    ./modules/programs/alacritty.nix
    ./modules/programs/firefox.nix
    ./modules/programs/vscode.nix
    ./modules/programs/mpv.nix
    ./modules/programs/nvim.nix
  ];
}
