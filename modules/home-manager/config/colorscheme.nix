{lib, ...}: {
  options.myhome.colorscheme = lib.mkOption {
    type = lib.types.attrs;
    description = "Colorscheme";

    # default = {
    #   colors = {};
    #   xcolors = {};
    # };
  };
}
