{
  config,
  inputs,
  lib,
  ...
}: {
  options = {
    myNixos.nix.enable = lib.mkEnableOption "Enables nix";
  };

  config = lib.mkIf config.myNixos.nix.enable {
    nixpkgs = {
      overlays = [
        inputs.nur.overlay
      ];

      config.allowUnfree = true;
    };

    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    system.stateVersion = "23.05";
  };
}
