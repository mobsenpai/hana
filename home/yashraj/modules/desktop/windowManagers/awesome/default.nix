{
  config,
  pkgs,
  inputs,
  ...
}: {
  home = {
    sessionVariables = {
      BROWSER = "firefox";
      EDITOR = "nvim";
    };

    file = {
      # ".config/awesome/rc.lua".source = ./rc.lua;
      ".config/awesome/module/lain".source = "${pkgs.lain}/share/lain";
      # ".config/awesome/modules/bling".source = inputs.bling.outPath;
      # ".config/awesome/modules/freedesktop".source = inputs.freedesktop.outPath;
    };
  };

  imports = [
    # ../../dunst
    ../../gtk.nix
    ../../picom.nix
    # ../../rofi.nix
  ];
}
