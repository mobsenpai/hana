{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myNixos.bash.enable = lib.mkEnableOption "Enables bash";
  };

  config = lib.mkIf config.myNixos.bash.enable {
    programs.bash = {
      promptInit = ''
        eval "$(${pkgs.starship}/bin/starship init bash)"
      '';
    };
  };
}
