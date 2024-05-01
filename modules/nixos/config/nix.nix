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
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        flake-registry = "";
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    nixpkgs = {
      config.allowUnfree = true;

      overlays = [
        inputs.nur.overlay
      ];
    };

    system.stateVersion = "23.11";
  };
}
