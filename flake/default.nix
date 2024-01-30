{
  imports = [
    ../home/yashraj
    ../hosts
    ../lib
    ../modules
  ];

  systems = ["x86_64-linux"];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        deadnix
        git
        nil
      ];

      name = "hana";
      meta.description = "The default development shell";
    };

    formatter = pkgs.alejandra;
  };
}
