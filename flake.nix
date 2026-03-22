{
  description = "Yash Raj's NixOS Flake";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib.extend (final: prev: (import ./lib self final) // home-manager.lib);
  in {
    formatter = lib.forEachSystem (pkgs: pkgs.alejandra);
    templates = import ./templates;

    nixosConfigurations = lib.listToAttrs [
      (lib.mkHost "hana" "yashraj" "x86_64-linux")
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
  };
}
