{
  lib,
  pkgs,
  ...
}: {
  myhome = {
    desktop.enable = true;

    hyprland.enable = true;
  };

  myhome.colorscheme.colors = {
    dark-red = "cc241d";
    red = "fb4934";
    dark-green = "98971a";
    green = "b8bb26";
    dark-yellow = "d79921";
    yellow = "fabd2f";
    dark-blue = "458588";
    blue = "83a598";
    dark-purple = "b16286";
    purple = "d3869b";
    dark-aqua = "689d6a";
    aqua = "8ec07c";
    dark-orange = "d65d0e";
    orange = "fe8019";
    dark-black = "1d2021"; # ----
    black = "282828"; # ---
    soft-black = "3c3836"; # --
    light-black = "504945"; # -
    dark-gray = "928374"; # +
    gray = "a89984"; # ++
    white = "ebdbb2"; # +++
  };

  myhome.wallpaper = let
    url = "https://i.imgur.com/nV0jfST.png";
    sha256 = "195mzd8ryyqzl8brlpsq0ww0llzjzi3cw0nirb98iax730cz3xby";
  in
    builtins.fetchurl {
      name = "wallpaper-${sha256}.png";
      inherit url sha256;
    };
}
