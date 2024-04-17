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
    black = "282828";
    red = "cc241d";
    green = "98971a";
    yellow = "d79921";
    blue = "458588";
    magenta = "b16286";
    cyan = "689d6a";
    white = "a89984";
    brightblack = "928374";
    brightred = "fb4934";
    brightgreen = "b8bb26";
    brightyellow = "fabd2f";
    brightblue = "83a598";
    brightmagenta = "d3869b";
    brightcyan = "8ec07c";
    brightwhite = "ebdbb2";
    darkbg = "1d2021";
    lightbg = "32302f";
    lightbg2 = "3c3836";
    orange = "d65d0e";
    brightorange = "fe8019";
  };

  myhome.wallpaper = let
    url = "https://i.imgur.com/mcW1tIA.png";
    sha256 = "1zk3hsgqi4sgwshb6r7dj64apsky76xwspnvclbkr658lkadwd7g";
  in
    builtins.fetchurl {
      name = "wallpaper-${sha256}.png";
      inherit url sha256;
    };
}
