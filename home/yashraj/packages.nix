{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      pcmanfm
      nitch
      neovim
      htop
      feh
      volumeicon
      ;
  };
}
