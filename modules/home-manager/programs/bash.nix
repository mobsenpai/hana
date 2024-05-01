{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myHome.bash.enable = lib.mkEnableOption "Enables bash";
  };

  config = lib.mkIf config.myHome.bash.enable {
    myHome.panes.enable = lib.mkDefault true;

    programs.bash = {
      enable = true;
      historyControl = ["erasedups" "ignorespace"];
      historyFile = "${config.xdg.dataHome}/bash/bash_history";
      shellOptions = [
        "autocd"
        "cdspell"
        "cmdhist"
        "dotglob"
        "histappend"
        "expand_aliases"
      ];

      initExtra = ''
        # Ignore upper and lowercase when TAB completion
        bind "set completion-ignore-case on"

        # Enable vi mode
        set -o vi

        # Binds specific to vi mode
        bind -m vi-command 'Control-l: clear-screen'
        bind -m vi-insert 'Control-l: clear-screen'

        # Aesthetics
        panes
      '';

      shellAliases = {
        cat = "${pkgs.bat}/bin/bat --color=always --style=plain";
        fcd = "cd $(${pkgs.fd}/bin/fd --type d | ${pkgs.skim}/bin/sk)";
        fm = "${pkgs.yazi}/bin/yazi";
        grep = "${pkgs.ripgrep}/bin/rg";
        ls = "${pkgs.eza}/bin/eza -alh --icons --git --group-directories-first";
        rm = "${pkgs.trash-cli}/bin/trash-put";
        ytmp3 = ''${pkgs.yt-dlp}/bin/yt-dlp -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';
      };
    };
  };
}
