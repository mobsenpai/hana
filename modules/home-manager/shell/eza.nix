{
  lib,
  config,
  ...
}: let
  cfg = config.modules.shell;
in
  lib.mkIf cfg.enable
  {
    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableBashIntegration = false;
    };

    programs.bash.shellAliases = {
      l = "ll";
      ls = "eza";
      ll = "eza -l";
      lll = "ll -snew --group-directories-first";
      la = "eza -la";
      laa = "la -snew --group-directories-first";
    };

    home.sessionVariables = {
      EZA_COLORS = "di=34;1:mp=34;1:bu=33;1:cm=90";
    };
  }
