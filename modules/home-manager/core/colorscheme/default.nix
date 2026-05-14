{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types mkIf;
  cfg = config.modules.colorScheme;

  presetDir = ./presets;
  presetFiles = builtins.readDir presetDir;
  nixFiles =
    lib.filterAttrs
    (name: type: type == "regular" && lib.hasSuffix ".nix" name)
    presetFiles;
  presets =
    lib.mapAttrs'
    (name: _: {
      name = lib.removeSuffix ".nix" name;
      value = import (presetDir + "/${name}");
    })
    nixFiles;
in {
  options.modules.colorScheme = {
    preset = mkOption {
      type = types.nullOr (types.enum (builtins.attrNames presets));
      default = null;
      description = "Which color scheme preset to use.";
    };

    # Use styleguide
    # https://github.com/tinted-theming/base24/blob/main/styling.md
    colors = mkOption {
      type = types.attrs;
      default = {};
      description = "Attribute set of colors";
    };

    xcolors = mkOption {
      type = types.attrs;
      default = lib.mapAttrsRecursive (_: color: "#${color}") cfg.colors;
      description = "Like colors, but # prepended to each value";
    };

    polarity = mkOption {
      type = types.enum ["light" "dark"];
      default = "dark";
      description = "Whether the color scheme is light or dark";
    };
  };

  config = mkIf (cfg.preset != null) {
    modules.colorScheme.colors = (presets.${cfg.preset}).colors;
    modules.colorScheme.polarity = (presets.${cfg.preset}).polarity;
  };
}
