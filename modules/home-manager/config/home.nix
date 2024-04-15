{
  config,
  lib,
  ...
}: {
  options = {
    myhome.home.enable = lib.mkEnableOption "enables home";
  };

  config = lib.mkIf config.myhome.home.enable {
    home = {
      username = "yashraj";
      homeDirectory = "/home/yashraj";
      extraOutputsToInstall = ["doc" "devdoc"];
    };

    home.stateVersion = "23.11";
  };
}
