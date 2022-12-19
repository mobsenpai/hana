# { config, theme, ... }:
{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    # settings = {
    #   imports = {
    #     "./colors-yml.nix"
    #   };
    # };
  };
  home.file.".config/alacritty/colors.yml".source = ./colors.yml;
  home.file.".config/alacritty/alacritty.yml".text = ''
      ## Import files (Colors, Fonts, Etc)
      import:
        - ~/.config/alacritty/colors.yml
        - ~/.config/alacritty/fonts.yml

      ## Set environment variables
      env:
        TERM: alacritty
        WINIT_X11_SCALE_FACTOR: '1.0'

      ## Terminal window settings
      window:
        dimensions:
          columns: 82
          lines: 24

        padding:
          x: 12
          y: 12

        decorations: full
        startup_mode: Windowed
        dynamic_title: true

      ## scrolling
        history: 10000
        multiplier: 3

      ## Background opacity
        opacity: 1.0

      ## Cursor
      cursor:
        style:
          shape: Beam
          blinking: On

        unfocused_hollow: false

      ## Live config reload
      live_config_reload: true

      ## Shell
      #shell:
      #  program: /bin/zsh
      #  args:
      #    - --login
  '';
}