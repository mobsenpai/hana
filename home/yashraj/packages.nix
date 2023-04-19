{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      nitch
      htop
      xss-lock
      ;
  };
}
