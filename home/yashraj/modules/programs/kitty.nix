{
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  programs.kitty = {
    enable = true;
    settings = {
      # background_opacity = "0.1";
      inactive_text_alpha = "1.0";
      window_padding_width = "12 24 0 24";
      placement_strategy = "center";
      # resize_in_steps = "yes";
      enabled_layouts = "*";
      remember_window_size = "no";
      initial_window_width = "640";
      initial_window_height = "400";
      confirm_os_window_close = "0";
      allow_remote_control = "yes";

      # URLs
      url_style = "double";
      copy_on_select = "yes";

      # Selection
      select_by_word_characters = ":@-./_~?&=%+#";

      # Mouse
      click_interval = "0.5";
      mouse_hide_wait = "0";
      focus_follows_mouse = "no";

      # Bell
      visual_bell_duration = "0.0";
      enable_audio_bell = "no";

      # Scroolback
      scrollback_lines = "10000";
      wheel_scroll_multiplier = "5.0";
      touch_scroll_multiplier = "1.0";

      # Tab bar
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";

      # Cursor
      cursor_shape = "underline";
      cursor_beam_thickness = "1.2";
      cursor_underline_thickness = "2.0";
      cursor_blink_interval = "-1.0";
      cursor_stop_blinking_after = "5.0";

      # Font
      # kitty +list-fonts --psnames | grep Jet
      font_family = "JetBrains Mono Bold Nerd Font Complete";
      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";
      font_size = "10.0";
      disable_ligatures = "never";
      adjust_line_height = "0";
      adjust_column_width = "0";
      box_drawing_scale = "0.001, 1, 1.5, 2";

      # The basic colors
      foreground = "#${colors.base0F}";
      background = "#${colors.base00}";
      selection_background = "#${colors.base0F}";
      selection_foreground = "#${colors.base00}";

      # Cursor colors
      cursor = "#${colors.base04}";
      cursor_text_color = "#${colors.base00}";

      # URL underline color when hovering with mouse
      url_color = "#${colors.base04}";

      # Kitty window border colors
      # active_border_color = "#${colors.base03}";
      # inactive_border_color = "#${colors.base01}";

      # Tab bar colors
      active_tab_background = "#${colors.base00}";
      active_tab_foreground = "#${colors.base06}";
      inactive_tab_background = "#${colors.base08}";
      inactive_tab_foreground = "#${colors.base04}";
      tab_bar_background = "#${colors.base08}";

      # Base16 colors
      # Normal
      color0 = "#${colors.base00}";
      color1 = "#${colors.base01}";
      color2 = "#${colors.base02}";
      color3 = "#${colors.base03}";
      color4 = "#${colors.base04}";
      color5 = "#${colors.base05}";
      color6 = "#${colors.base06}";
      color7 = "#${colors.base07}";

      # Bright
      color8 = "#${colors.base08}";
      color9 = "#${colors.base09}";
      color10 = "#${colors.base0A}";
      color11 = "#${colors.base0B}";
      color12 = "#${colors.base0C}";
      color13 = "#${colors.base0D}";
      color14 = "#${colors.base0E}";
      color15 = "#${colors.base0F}";
    };
    # Keys
    keybindings = {
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "ctrl+shift+c" = "copy_to_clipboard";
      "shift+insert" = "paste_from_selection";

      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
      "ctrl+shift+h" = "show_scrollback";

      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+w" = "close_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
      "ctrl+shift+1" = "first_window";
      "ctrl+shift+2" = "second_window";
      "ctrl+shift+3" = "third_window";
      "ctrl+shift+4" = "fourth_window";
      "ctrl+shift+5" = "fifth_window";
      "ctrl+shift+6" = "sixth_window";
      "ctrl+shift+7" = "seventh_window";
      "ctrl+shift+8" = "eighth_window";
      "ctrl+shift+9" = "ninth_window";
      "ctrl+shift+0" = "tenth_window";

      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+." = "move_tab_forward";
      "ctrl+shift+," = "move_tab_backward";
      "ctrl+shift+alt+t" = "set_tab_title";

      "ctrl+shift+equal" = "increase_font_size";
      "ctrl+shift+minus" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
    };
  };
}
