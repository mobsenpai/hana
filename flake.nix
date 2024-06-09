{
  description = ''
    ███╗░░░███╗░█████╗░██████╗░██╗░██████╗  ███╗░░██╗██╗██╗░░██╗░█████╗░░██████╗
    ████╗░████║██╔══██╗██╔══██╗╚█║██╔════╝  ████╗░██║██║╚██╗██╔╝██╔══██╗██╔════╝
    ██╔████╔██║██║░░██║██████╦╝░╚╝╚█████╗░  ██╔██╗██║██║░╚███╔╝░██║░░██║╚█████╗░
    ██║╚██╔╝██║██║░░██║██╔══██╗░░░░╚═══██╗  ██║╚████║██║░██╔██╗░██║░░██║░╚═══██╗
    ██║░╚═╝░██║╚█████╔╝██████╦╝░░░██████╔╝  ██║░╚███║██║██╔╝╚██╗╚█████╔╝██████╔╝
    ╚═╝░░░░░╚═╝░╚════╝░╚═════╝░░░░╚═════╝░  ╚═╝░░╚══╝╚═╝╚═╝░░╚═╝░╚════╝░╚═════╝░
  '';

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {...} @ inputs: {
    homeManagerModules.default = ./modules/home-manager;
    nixosModules.default = ./modules/nixos;

    nixosConfigurations = {
      hana = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/hana/configuration.nix
          inputs.self.outputs.nixosModules.default
          inputs.home-manager.nixosModules.home-manager

          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              users.yashraj.imports = [
                ./home/hana.nix
                inputs.self.outputs.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
  };
}
