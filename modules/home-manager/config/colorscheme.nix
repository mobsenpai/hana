{
  config,
  lib,
  ...
}: {
  options.myHome.colorscheme = {
    colors = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Attribute set of colors";
    };

    xcolors = lib.mkOption {
      type = lib.types.attrs;
      default = lib.mapAttrsRecursive (_: color: "#${color}") config.myHome.colorscheme.colors;
      description = "Adds # to colors";
    };
  };
}
