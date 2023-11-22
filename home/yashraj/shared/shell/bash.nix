{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config) colorscheme;
in {
  programs.bash = with pkgs; {
    enable = true;
    historyControl = ["erasedups" "ignorespace"];
    shellOptions = [
      "autocd"
      "cdspell"
      "cmdhist"
      "dotglob"
      "histappend"
      "expand_aliases"
    ];

    initExtra = with colorscheme.colors; ''
      # General
      # =============================================
      # ignore upper and lowercase when TAB completion
      bind "set completion-ignore-case on"

      # set vim keybindings
      set -o vi
      # fix ctrl+l not working when using vim keybinds
      bind -m vi-command 'Control-l: clear-screen'
      bind -m vi-insert 'Control-l: clear-screen'

      # fzf
      export FZF_DEFAULT_OPTS="
        --color fg:#${base04}
        --color fg+:#${base06}
        --color bg:#${base00}
        --color bg+:#${base01}
        --color hl:#${base0D}
        --color hl+:#${base0D}
        --color info:#${base0A}
        --color marker:#${base0C}
        --color prompt:#${base0A}
        --color spinner:#${base0C}
        --color pointer:#${base0C}
        --color header:#${base0D}
        --color preview-fg:#${base0D}
        --color preview-bg:#${base01}
        --color gutter:#${base00}
        --color border:#${base01}
        --border
        --prompt 'λ '
        --pointer ''
        --marker ''
      "

      # ex = Extractor for all kinds of archives
      # =============================================
      # usage: ex <file>
      ex() {
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

      # Reporting tools
      # =============================================
      ${lib.getExe neofetch}
    '';

    shellAliases = {
      dev = "nix develop";
      ls = "${lib.getExe exa} -ah --git --icons --color=auto --group-directories-first -s extension";
      c = "clear";
      rm = lib.getExe trash-cli;
      fcd = "cd $(find -type d | ${lib.getExe fzf})";
      fm = "${lib.getExe fzf} --preview 'preview.sh {}'";
      grep = lib.getExe ripgrep;
      cat = "${lib.getExe bat} --color=always --style=plain";
      commit = "${lib.getExe git} add . && ${lib.getExe git} commit -m";
      push = "${lib.getExe git} push";
      pull = "${lib.getExe git} pull";
      ytmp3 = ''${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
    };
  };
}
