{
  inputs,
  config,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;

  # Custom colorscheme list
  # default-dark = (import ./default-dark.nix).colorscheme;
  default-dark = (import ./gruvbox-medium.nix).colorscheme;
in {
  imports = [
    inputs.nix-colors.homeManagerModule
  ];

  # Use the custom color scheme
  colorscheme = gruvbox-medium;

  # Use the colorscheme available at github:tinted-theming/base16-schemes
  # colorscheme = colorSchemes.ashes;
}
