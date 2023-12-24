{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;
in {
  imports = [
    inputs.nix-colors.homeManagerModule
    ./shell
  ];

  systemd.user.startServices = "sd-switch";

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];

    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;

  home = {
    username = "yashraj";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.05";
  };

  # Use the colorscheme available at https://github.com/tinted-theming/base16-schemes
  colorscheme = colorSchemes.gruvbox-dark-medium;
}
