{
  description = ''
    ███╗░░░███╗░█████╗░██████╗░██╗░██████╗  ███╗░░██╗██╗██╗░░██╗░█████╗░░██████╗
    ████╗░████║██╔══██╗██╔══██╗╚█║██╔════╝  ████╗░██║██║╚██╗██╔╝██╔══██╗██╔════╝
    ██╔████╔██║██║░░██║██████╦╝░╚╝╚█████╗░  ██╔██╗██║██║░╚███╔╝░██║░░██║╚█████╗░
    ██║╚██╔╝██║██║░░██║██╔══██╗░░░░╚═══██╗  ██║╚████║██║░██╔██╗░██║░░██║░╚═══██╗
    ██║░╚═╝░██║╚█████╔╝██████╦╝░░░██████╔╝  ██║░╚███║██║██╔╝╚██╗╚█████╔╝██████╔╝
    ╚═╝░░░░░╚═╝░╚════╝░╚═════╝░░░░╚═════╝░  ╚═╝░░╚══╝╚═╝╚═╝░░╚═╝░╚════╝░╚═════╝░
  '';

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./flake];};

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nur.url = "github:nix-community/NUR";

    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
