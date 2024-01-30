{pkgs}: let
  webEnv = with pkgs; [
    nodejs
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
  ];
in
  pkgs.mkShell {
    nativeBuildInputs = [webEnv];
  }
