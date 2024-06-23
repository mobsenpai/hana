{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.git;
in
  lib.mkIf cfg.enable
  {
    programs.git = {
      enable = true;
      delta.enable = true;

      userEmail = "work.velocity806@passinbox.com";
      userName = "mobsenpai";

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
  }
