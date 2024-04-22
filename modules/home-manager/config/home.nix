{
  config,
  lib,
  ...
}: {
  options = {
    myhome.home.enable = lib.mkEnableOption "Enables home";
  };

  config = lib.mkIf config.myhome.home.enable {
    home = {
      username = "yashraj";
      homeDirectory = "/home/yashraj";
    };

    home.stateVersion = "23.11";
  };
}
