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
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
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
