{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home.nix
    ./packages.nix

    # ./modules/colorschemes
    #./modules/shell
    # ./modules/desktop/windowManagers/hyprland
    # ./modules/desktop/windowManagers/awesome.nix

    # ./modules/programs/discord.nix
    # ./modules/programs/kitty.nix
    # ./modules/programs/mpd.nix
    # ./modules/programs/neovim.nix
    # ./modules/programs/vscode.nix
    # ./modules/programs/zathura.nix

    #./modules/programs/firefox
    # (import ./modules/programs/firefox {
    #   inherit config pkgs;
    #   package = pkgs.firefox-wayland;
    # })
  ];
}
