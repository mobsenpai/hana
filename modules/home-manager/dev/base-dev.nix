{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.base-dev.enable = lib.mkEnableOption "enables base dev";
  };

  config = lib.mkIf config.myhome.base-dev.enable {
    home.packages = with pkgs; [
      alejandra
      nodejs
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
    ];
  };
}
