{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./xdg.nix
    ./bash.nix
    ./starship.nix
    ./cli.nix
    ./git.nix
    ./nix.nix
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

          case "$(${lib.getExe file} --mime-type "$1")" in
            *text*)
              ${lib.getExe bat} --color always --plain "$1"
              ;;
            *image* | *pdf)
              ${lib.getExe catimg} -w 100 -r 2 "$1"
              ;;
            *directory*)
              ${lib.getExe eza} --icons -1 --color=always "$1"
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
