{
  config,
  lib,
  ...
}: {
  options = {
    mynixos.i18n.enable = lib.mkEnableOption "Enables i18n";
  };

  config = lib.mkIf config.mynixos.i18n.enable {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
    };
  };
}
