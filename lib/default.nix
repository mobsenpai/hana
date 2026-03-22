self: final: let
  lib = final;
  utils = import ./utils.nix lib;
in {
  inherit utils;

  forEachSystem = f:
    lib.genAttrs ["x86_64-linux"] (system: f (import self.inputs.nixpkgs {inherit system;}));

  mkHost = hostname: username: system: {
    name = hostname;
    value = lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit (self) inputs;
        inherit self hostname username;
        lib = final;
      };
      modules =
        if (lib.hasPrefix "installer" hostname)
        then [../hosts/installer]
        else [
          ../hosts/${hostname}
          ../modules/nixos
        ];
    };
  };
}
