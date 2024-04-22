{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.base-dev.enable = lib.mkEnableOption "Enables base dev";
  };

  config = lib.mkIf config.myhome.base-dev.enable {
    home.packages = with pkgs; [
      alejandra
      emmet-ls
      nil
      nodejs
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
    ];
  };
}
