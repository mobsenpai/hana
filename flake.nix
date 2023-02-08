{
  description = "Mob's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nix-colors.url = "github:misterio77/nix-colors";
    # nur.url = "github:nix-community/NUR";
    # devshell.url = "github:numtide/devshell";
    # flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # crane = {
    #   url = "github:ipetkov/crane";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nil = {
    #   url = "github:oxalica/nil";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.rust-overlay.follows = "rust-overlay";
    # };

    # Non Flakes
    # firefox-csshacks = {
    #   url = "github:MrOtherGuy/firefox-csshacks";
    #   flake = false;
    # };

    # arkenfox = {
    #   url = "github:arkenfox/user.js";
    #   flake = false;
    # };

    # awesome modules
    lain = {
      url = "github:lcpz/lain";
      flake = false;
    };

    # bling = {
    #   type = "git";
    #   url = "https://github.com/BlingCorp/bling.git";
    #   flake = false;
    # };

    # freedesktop = {
    #   type = "git";
    #   url = "https://github.com/lcpz/awesome-freedesktop.git";
    #   flake = false;
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
    forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};
    packages = forEachPkgs (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});

    nixosConfigurations = {
      # Laptop
      acer = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/acer];
      };
    };

    homeConfigurations = {
      # Laptop
      "yashraj@acer" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./home/yashraj];
      };
    };
  };
}
