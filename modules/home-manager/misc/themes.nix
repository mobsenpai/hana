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
  ];

  # Use the colorscheme available at https://github.com/tinted-theming/base16-schemes
  colorscheme = colorSchemes.gruvbox-dark-medium;
}
