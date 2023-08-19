{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  programs.bash = {
    enable = true;

    initExtra = ''
      bind "set completion-ignore-case on"

      # shopt
      shopt -s autocd # change to named directory
      shopt -s cdspell # autocorrects cd misspellings
      shopt -s cmdhist # save multi-line commands in history as single line
      shopt -s dotglob
      shopt -s histappend # do not overwrite history
      shopt -s expand_aliases # expand aliases

      # ex = EXtractor for all kinds of archives
      # usage: ex <file>
      ex ()
      {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1   ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *.deb)       ar x $1      ;;
            *.tar.xz)    tar xf $1    ;;
            *.tar.zst)   tar xf $1    ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }

      # reporting tools - install when not installed
      neofetch
    '';

    shellAliases = with pkgs; {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      v = "nvim";
      g = "git";
      commit = "git add . && git commit -m";
      push = "git push";
      pull = "git pull";
      m = "mkdir -p";
      fcd = "cd $(find -type d | fzf)";
      grep = lib.getExe ripgrep;
      du = lib.getExe du-dust;
      ps = lib.getExe procs;
      rm = lib.getExe trash-cli;
      cat = "${lib.getExe bat} --style=plain";
      l = "${lib.getExe exa} -lF --time-style=long-iso --icons";
      la = "${lib.getExe exa} -lah --tree";
      ls = "${lib.getExe exa} -h --git --icons --color=auto --group-directories-first -s extension";
      tree = "${lib.getExe exa} --tree --icons --tree";
      ytmp3 = ''
        ${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
      '';
    };
  };
}
