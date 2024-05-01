{
  config,
  lib,
  ...
}: {
  options = {
    myHome.git.enable = lib.mkEnableOption "Enables git";
  };

  config = lib.mkIf config.myHome.git.enable {
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
