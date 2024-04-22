{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    mynixos.system-path.enable = lib.mkEnableOption "Enables system-path";
  };

  config = lib.mkIf config.mynixos.system-path.enable {
    environment = {
      systemPackages = with pkgs; [
        git
        neovim
        starship
        vim
      ];
    };
  };
}
