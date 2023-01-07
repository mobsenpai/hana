{
  inputs,
  outputs,
  ...
}: let
  sharedModules = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs outputs;};
        users.yashraj = ../home/yashraj;
      };
    }
  ];
in {
  acer = outputs.lib.nixosSystem {
    modules =
      [
        ./acer
        {networking.hostName = "acer";}
      ]
      ++ sharedModules;

    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
  };
}
