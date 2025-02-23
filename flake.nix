{
  description = "Yash Raj's NixOS Flake";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (lib) nixosSystem genAttrs hasPrefix;
    lib = nixpkgs.lib.extend (final: prev: (import ./lib final) // home-manager.lib);

    systems = ["x86_64-linux"];
    forEachSystem = f:
      genAttrs systems (system:
        f (nixpkgs.legacyPackages.${system}));

    mkHost = hostname: username: system: {
      ${hostname} = nixosSystem {
        inherit system;
        specialArgs = {
          inherit self inputs hostname username lib;
        };
        modules =
          if (hasPrefix "installer" hostname)
          then [./hosts/installer]
          else [
            ./hosts/${hostname}
            ./modules/nixos
          ];
      };
    };
  in {
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    templates = import ./templates;

    nixosConfigurations = mkHost "hana" "yashraj" "x86_64-linux";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
  };
}
