{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) utils mkEnableOption;
in {
  imports = utils.scanPaths ./.;

  options.modules.core = {
    homeManager.enable = mkEnableOption "home-manager";
  };

  config = {
    environment.systemPackages = [
      pkgs.git
    ];

    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
    };

    time.timeZone = "Asia/Kolkata";

    environment.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };

    system.stateVersion = "23.05";
  };
}
