{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mynixos.bash.enable = lib.mkEnableOption "Enables bash";
  };

  config = lib.mkIf config.mynixos.bash.enable {
    programs.bash = {
      promptInit = ''
        eval "$(${pkgs.starship}/bin/starship init bash)"
      '';
    };
  };
}
