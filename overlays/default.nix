{
  outputs,
  inputs,
}: let
  # Adds my custom packages
  additions = final: _: import ../pkgs {pkgs = final;};

  # Modifies existing packages
  modifications = final: prev: {
    awesome-git-luajit = inputs.nixpkgs-f2k.packages.${prev.system}.awesome-git.override {
      lua = prev.luajit;
    };

    picom = inputs.nixpkgs-f2k.packages.${prev.system}.picom-git;
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
