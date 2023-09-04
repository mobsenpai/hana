{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      cava
      cbonsai
    ;
  };
}
