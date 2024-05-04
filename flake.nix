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
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hypridle.inputs.nixpkgs.follows = "nixpkgs";
    hyprlock.inputs.nixpkgs.follows = "nixpkgs";
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
