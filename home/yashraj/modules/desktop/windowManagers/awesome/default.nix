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
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";

      # QT Variables
      # QT_QPA_PLATFORMTHEME = "gtk2";

      # Theming Related Variables
      # GTK_THEME = "gruvbox-dark";
      # XCURSOR_SIZE = "24";
    };

    file = {
      ".config/awesome/rc.lua".source = ./rc.lua;
      # ".config/awesome/rc.lua".source = ./rc2.lua;
      # ".config/awesome/modules/bling".source = inputs.bling.outPath;
      # ".config/awesome/modules/lain".source = inputs.lain.outPath;
      # ".config/awesome/modules/freedesktop".source = inputs.freedesktop.outPath;
    };
  };

  # xsession = {
  #   enable = true;
  #   windowManager.awesome = {
  #     enable = true;
  #     package = pkgs.awesome;
  #     # extraConfig = import ./rc-lua.nix;
  #   };
  # };

  imports = [
    # ../../dunst
    ../../gtk.nix
    # ../../rofi.nix
  ];
}
