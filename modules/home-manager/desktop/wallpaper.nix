{lib, ...}: {
  options.modules.desktop.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = ../../../assets/wall.jpg;
    description = "Wallpaper image";
  };
}
