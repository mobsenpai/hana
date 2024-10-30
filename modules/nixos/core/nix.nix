{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mapAttrs filterAttrs isType mapAttrsToList;
in {
  nixpkgs = {
    overlays = [
      (final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = final.system;
          config.allowUnfree = true;
        };
      })
    ];

    config.allowUnfree = true;
  };

  nix = let
    flakeInputs = filterAttrs (_: isType "flake") inputs;
  in {
    channel.enable = false;

    # Populates the nix registry with all our flake inputs `nix registry list`
    registry = mapAttrs (_: flake: {inherit flake;}) flakeInputs;

    # Add flake inputs to nix path. Enables loading flakes with <flake_name>
    # like how <nixpkgs> can be referenced.
    nixPath = mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Do not load the default global registry
      # https://channels.nixos.org/flake-registry.json
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
  };
}
