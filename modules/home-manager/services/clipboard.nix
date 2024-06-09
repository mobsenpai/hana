{
  config,
  lib,
  ...
}: {
  options = {
    myHome.clipboard.enable = lib.mkEnableOption "Enables clipboard";
  };

  config = lib.mkIf config.myHome.clipboard.enable {
    services.cliphist.enable = true;
  };
}
