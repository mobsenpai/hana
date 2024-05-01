{lib, ...}: {
  options.myHome.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = "";
    description = "Wallpaper path";
  };
}
