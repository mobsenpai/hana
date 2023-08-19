{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        alejandra
        # any-nix-shell
        
        # deadnix
        
        nix-index
        # statix
        
        ;
    };

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
  };

  programs = {
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
