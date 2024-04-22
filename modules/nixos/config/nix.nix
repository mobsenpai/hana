{
  config,
  inputs,
  lib,
  ...
}: {
  options = {
    mynixos.nix.enable = lib.mkEnableOption "Enables nix";
  };

  config = lib.mkIf config.mynixos.nix.enable {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;

    nixpkgs.overlays = [
      inputs.nur.overlay
    ];

    system.stateVersion = "23.11";
  };
}
