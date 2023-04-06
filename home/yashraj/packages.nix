{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      nitch
      neovim
      htop
      betterlockscreen
      xss-lock
      ;
  };
}
