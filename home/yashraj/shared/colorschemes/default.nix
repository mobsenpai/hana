{
  inputs,
  config,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;
  # Custom colorscheme list
  # custom = (import ./custom.nix).colorscheme;
in {
  imports = [
    inputs.nix-colors.homeManagerModule
  ];

  # Use the custom color scheme
  # colorscheme = custom;

  # Use the colorscheme available at github:tinted-theming/base16-schemes
  colorscheme = colorSchemes.gruvbox-dark-medium;
}
