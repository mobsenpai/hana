{
  inputs,
  self,
  themes,
  ...
}: let
  extraSpecialArgs = {inherit inputs self themes;};

  homeImports = {
    "yashraj@hiru" = [
      ./home.nix
      ./hiru.nix
    ];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "yashraj@hiru" = homeManagerConfiguration {
        modules = homeImports."yashraj@hiru";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
