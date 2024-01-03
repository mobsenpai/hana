{
  config,
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
      "neofetch"
    '';

    shellAliases = {
      nd = "nix develop -c $SHELL";
      nsn = "nix shell nixpkgs#";
      nbn = "nix build nixpkgs#";
      snrs = "sudo nixos-rebuild --flake . switch";
      hms = "home-manager --flake . switch";

      cat = "bat --color=always --style=plain";
      fcd = "cd $(fd --type d | sk)";
      fm = "yazi";
      grep = "rg";
      ls = "eza -alh --icons --git --group-directories-first";
      rm = "trash";
      ytmp3 = ''yt-dlp -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
    };
  };
}
