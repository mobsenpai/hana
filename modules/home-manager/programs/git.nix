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

      settings = {
        user.email = "work.velocity806@passinbox.com";
        user.name = "mobsenpai";
        init.defaultBranch = "main";
      };

      ignores = [
        "*~"
        "*.swp"
        "*result*"
        "node_modules"
      ];
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  }
