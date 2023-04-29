{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      pfetch
      htop
      playerctl
      # lsp
      
      lua-language-server
      nil
      # formatters
      
      stylua
      ;

    inherit
      (pkgs.luaPackages)
      lua
      ;

    inherit
      (pkgs.nodePackages_latest)
      prettier
      vscode-langservers-extracted
      typescript-language-server
      ;
  };
}
