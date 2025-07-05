# TODO:
# 1. finalise wallpaper module
{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  options.modules.desktop.wallpaper = {
    excludedTags = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Tags to exclude from the wallpaper pool.";
    };

    images = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          path = lib.mkOption {
            type = lib.types.path;
            description = "Path to the wallpaper image.";
          };
          tags = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "Tags for this wallpaper.";
          };
        };
      });
      default = inputs.nix-resources.wallpapers;
      apply = images:
        lib.filterAttrs (
          _: wallpaper:
            builtins.all (tag: !(builtins.elem tag config.modules.desktop.wallpaper.excludedTags)) wallpaper.tags
        )
        images;
      description = "Filtered wallpapers.";
      readOnly = true;
    };

    imagesDir = lib.mkOption {
      type = lib.types.path;
      default =
        pkgs.linkFarm "wallpapers"
        (lib.mapAttrsToList (name: w: {
            inherit name;
            path = w.path;
          })
          config.modules.desktop.wallpaper.images);
      description = "Directory containing symlinks to filtered wallpapers.";
      readOnly = true;
    };
  };
}
