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
    historyControl = ["erasedups" "ignorespace"];
    shellOptions = [
      "autocd"
      "cdspell"
      "cmdhist"
      "dotglob"
      "histappend"
      "expand_aliases"
    ];

    initExtra = with pkgs; ''
      # General
      # =============================================
      set -o vi
      # ignore upper and lowercase when TAB completion
      bind "set completion-ignore-case on"

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

      # Build functions = hbuild, build
      # =============================================
      # usage : build
      build() {
        host=$(hostname -f)
        sudo nixos-rebuild switch --flake ~/.setup#$host
      }
      # usage: hbuild <config>
      hbuild() {
        host=$(hostname -f)
        home-manager switch --flake ~/.setup#$@'@'$host
      }

      # Install functions = install, shell, run...
      # =============================================
      # usage: install <package>
      install() {
        nix-env -iA nixos.$@
      }
      uninstall(){
        nix-env --uninstall $@
      }
      list() {
        nix-env -q
      }
      # usage: tempin <package>
      shell() {
        nix shell nixpkgs#$@
      }
      # usage: run <package>
      run() {
        nix run nixpkgs#$@
      }

      # Reporting tools
      # =============================================
      ${lib.getExe neofetch}
    '';

    shellAliases = with pkgs; {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      dev = "nix develop $HOME/.setup";
      l = "${lib.getExe eza} -lF --time-style=long-iso --icons";
      la = "${lib.getExe eza} -lah --tree";
      ls = "${lib.getExe eza} -ah --git --icons --color=auto --group-directories-first -s extension";
      sl = "ls";
      tree = "${lib.getExe eza} --tree --icons --tree";
      c = "clear";
      rm = lib.getExe trash-cli;
      m = "mkdir -p";
      v = lib.getExe neovim;
      g = lib.getExe git;
      fm = lib.getExe ranger;
      grep = lib.getExe ripgrep;
      cat = "${lib.getExe bat} --color always --style=plain";
      du = lib.getExe du-dust;
      ps = lib.getExe procs;
      commit = "${lib.getExe git} add . && ${lib.getExe git} commit -m";
      push = "${lib.getExe git} push";
      pull = "${lib.getExe git} pull";
      ytmp3 = ''${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
    };
  };
}
