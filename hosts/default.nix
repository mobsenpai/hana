{
  homeImports,
  inputs,
  self,
  themes,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.self) nixosModules;
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = {inherit inputs self themes;};
  in {
    # HP
    yuki = nixosSystem {
      inherit specialArgs;
      modules = [
        ./yuki
        nixosModules.base
        nixosModules.bluetooth
        nixosModules.hyprland

        {
          home-manager = {
            users.yashraj.imports = homeImports."yashraj@hiru";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
