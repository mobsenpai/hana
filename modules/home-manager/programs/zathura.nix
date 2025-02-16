{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.zathura;
in
  lib.mkIf cfg.enable
  {
    programs.zathura = {
      enable = true;
      mappings = {
        # Map smooth scroll to j and k
        "j feedkeys" = "<C-Down>";
        "k feedkeys" = "<C-Up>";
      };
    };

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
    };

    programs.zsh.shellAliases = {
      pdf = "zathura";
    };
  }
