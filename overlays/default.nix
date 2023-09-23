{
  outputs,
  inputs,
}: let
  # Adds my custom packages
  additions = final: _: import ../pkgs {pkgs = final;};

  # Modifies existing packages
  modifications = final: prev: {
    awesome = inputs.nixpkgs-f2k.packages.${prev.system}.awesome-git;
    picom = inputs.nixpkgs-f2k.packages.${prev.system}.picom-dccsillag;
  };
in {
  default = final: prev: (additions final prev) // (modifications final prev);
}
