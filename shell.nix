# Shell for bootstrapping flake-enabled nix and other tooling
{
  pkgs ?
  # If pkgs is not defined, instanciate nixpkgs from locked commit
  let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git

      # Dev
      nodejs
      lua

      # Language servers
      lua-language-server
      nil
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted

      # Formatters
      alejandra
      stylua
      nodePackages.prettier
    ];
  };
}
