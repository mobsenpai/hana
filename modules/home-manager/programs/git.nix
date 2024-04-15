{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myhome.git.enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.myhome.git.enable {
    programs.git = {
      enable = true;
      delta.enable = true;

      userName = "mobsenpai";
      userEmail = "work.velocity806@passinbox.com";

      extraConfig = {
        init.defaultBranch = "main";
      };

      ignores = [
        "*~"
        "*.swp"
        "*result*"
        "node_modules"
      ];
    };
  };
}
