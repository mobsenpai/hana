{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bash.nix
    ./cli.nix
    ./git.nix
    ./starship.nix
    ./xdg.nix
  ];

  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    file = with pkgs; {
      ".local/bin/preview.sh" = {
        # Preview script for fzf tab
        executable = true;
        text = ''
          #> Syntax: bash

          case "$1" in
            -*) exit 0;;
          esac

          case "$(file --mime-type "$1")" in
            *text*)
              bat --color always --plain "$1"
              ;;
            *image* | *pdf)
              catimg -w 100 -r 2 "$1"
              ;;
            *directory*)
              eza --icons -1 --color=always "$1"
              ;;
            *)
              echo "unknown file format"
              ;;
          esac
        '';
      };
    };
  };
}
