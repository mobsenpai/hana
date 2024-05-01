{
  config,
  lib,
  ...
}: {
  options = {
    myHome.home.enable = lib.mkEnableOption "Enables home";
  };

  config = lib.mkIf config.myHome.home.enable {
    home = {
      username = "yashraj";
      homeDirectory = "/home/yashraj";
    };

    home.stateVersion = "23.11";
  };
}
