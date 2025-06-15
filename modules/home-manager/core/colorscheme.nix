{
  lib,
  config,
  ...
}: let
  cfg = config.modules.colorScheme;
in {
  options.modules.colorScheme = {
    colors = lib.mkOption {
      type = lib.types.attrs;
      default = null;
      description = "Attribute set of colors";
    };

    xcolors = lib.mkOption {
      type = lib.types.attrs;
      default = lib.mapAttrsRecursive (_: color: "#${color}") cfg.colors;
      description = "Adds # to colors";
    };

    type = lib.mkOption {
      type = lib.types.enum ["light" "dark"];
    };
  };
}
