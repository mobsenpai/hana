{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mynixos.bash.enable = lib.mkEnableOption "enables bash";
  };

  config = lib.mkIf config.mynixos.bash.enable {
    programs.bash = {
      promptInit = ''
        eval "$(${pkgs.starship}/bin/starship init bash)"
      '';
    };
  };
}
