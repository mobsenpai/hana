{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    myNixos.system-path.enable = lib.mkEnableOption "Enables system-path";
  };

  config = lib.mkIf config.myNixos.system-path.enable {
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
