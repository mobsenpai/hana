inputs: let
  inherit (inputs) self;
  inherit (self.lib) nixosSystem;

  sharedModules = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs self;};
        users.yashraj = ../home/yashraj;
      };
    }
  ];
in {
  nixos = nixosSystem {
    modules =
      [
        ./nixos
        {networking.hostName = "nixos";}
      ]
      ++ sharedModules;

    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
  };
}
