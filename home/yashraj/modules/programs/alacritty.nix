{
  config,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
  };
  home.file.".config/alacritty/alacritty.yml".text = ''
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
        # Font configuration
        font:
          # Normal (roman) font face
          normal:
            family: "JetBrainsMono Nerd Font"
            #style: Regular
          # Bold font face
          bold:
            family: "JetBrainsMono Nerd Font"
            #style: Bold
          # Italic font face
          italic:
            family: "JetBrainsMono Nerd Font"
            #style: Italic
          # Bold italic font face
          bold_italic:
            family: "JetBrainsMono Nerd Font"
            #style: Bold Italic
          # Point size
          size: 10
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

        ## Colourscheme
    colors:
      # Default colors
      primary:
        background: '0x${base00}'
        foreground: '0x${base0F}'

      # Normal colors
      normal:
        black:   '0x${base00}'
        red:     '0x${base09D}'
        green:   '0x${base0AD}'
        yellow:  '0x${base0BD}'
        blue:    '0x${base0CD}'
        magenta: '0x${base0DD}'
        cyan:    '0x${base0ED}'
        white:   '0x${base07}'

      # Bright colors
      bright:
        black:   '0x${base08}'
        red:     '0x${base09}'
        green:   '0x${base0A}'
        yellow:  '0x${base0B}'
        blue:    '0x${base0C}'
        magenta: '0x${base0D}'
        cyan:    '0x${base0E}'
        white:   '0x${base0F}'

  '';
}
