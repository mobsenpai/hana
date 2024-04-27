{
  myhome = {
    desktop.enable = true;

    hyprland.enable = true;
  };

  myhome.colorscheme.colors = {
    bg0 = "282828"; # main background
    bg1 = "3c3836";
    bg2 = "504945";
    bg3 = "665c54";
    bg4 = "7c6f64";

    fg0 = "fbf1c7";
    fg1 = "ebdbb2"; # main foreground
    fg2 = "d5c4a1";
    fg3 = "bdae93";
    fg4 = "a89984"; # gray0

    gray0 = "a89984";
    gray1 = "928374";

    red0 = "cc241d"; # neutral
    red1 = "fb4934"; # bright
    green0 = "98971a";
    green1 = "b8bb26";
    yellow0 = "d79921";
    yellow1 = "fabd2f";
    blue0 = "458588";
    blue1 = "83a598";
    purple0 = "b16286";
    purple1 = "d3869b";
    aqua0 = "689d6a";
    aqua1 = "8ec07c";
    orange0 = "d65d0e";
    orange1 = "fe8019";
  };

  myhome.wallpaper = builtins.fetchurl rec {
    name = "wallpaper-${sha256}.png";
    url = "https://i.imgur.com/nV0jfST.png";
    sha256 = "195mzd8ryyqzl8brlpsq0ww0llzjzi3cw0nirb98iax730cz3xby";
  };
}
