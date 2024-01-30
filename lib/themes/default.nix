lib: {
  colorscheme = rec {
    colors = {
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

    xcolors = lib.mapAttrsRecursive (_: color: "#${color}") colors;
  };
}
