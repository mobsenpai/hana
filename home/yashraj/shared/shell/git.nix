{
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      colordiff
      ;

    inherit
      (pkgs.gitAndTools)
      gitui
      ;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "MobSenpai";
    userEmail = "iamyashraj@proton.me";
    # signing = {
    #   key = "F01BC62D2BAE2122";
    #   signByDefault = true;
    # };

    delta = {
      enable = true;
    };

    extraConfig = {
      init = {defaultBranch = "main";};
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
      delta = {
        line-numbers = true;
      };
    };

    aliases = {
      co = "checkout";
      fuck = "commit --amend -m";
      ca = "commit -am";
      d = "diff";
      ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
      pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
      af = "!git add $(git ls-files -m -o --exclude-standard | fzf -m)";
      st = "status";
      br = "branch";
      df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
      hist = ''
        log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all'';
      llog = ''
        log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative'';
      edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; vim `f`";
    };

    ignores = [
      "*~"
      "*.swp"
      "*result*"
      ".direnv"
      "node_modules"
    ];
  };
}
