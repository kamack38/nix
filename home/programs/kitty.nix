{ config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.mode = "no-cursor no-cwd";
    # Font
    # font_family FiraCode Nerd Font Mono Med
    # bold_font FiraCode Nerd Font Mono
    # italic_font JetBrainsMono NFM Italic
    # bold_italic_font JetBrainsMono NFM Bold Italic
    settings = {
      font_size = 12;
      disable_ligatures = "never";

      # Cursour
      cursor_shape = "block";
      cursor_blink_interval = "0";

      # Window settings
      background_opacity = "0.8";
      remember_window_size = "no";
      initial_window_width = "1128";
      initial_window_height = "582";
      confirm_os_window_close = "0";
      window_padding_width = "0 1";
      enabled_layouts = "splits:split_axis=horizontal";
      # Color settings
      background = config.var.theme.colors.c0;
      foreground = config.var.theme.colors.c7;
      selection_background = config.var.theme.colors.c7;

      # Tab Bar
      active_tab_background = "#168aad";
      active_tab_foreground = "#d8dee9";
      inactive_tab_foreground = config.var.theme.colors.c7;
      inactive_tab_background = "#282c34";

      color0 = "#" + config.var.theme.colors.c0;
      color1 = "#" + config.var.theme.colors.c1;
      color2 = "#" + config.var.theme.colors.c2;
      color3 = "#" + config.var.theme.colors.c3;
      color4 = "#" + config.var.theme.colors.c4;
      color5 = "#" + config.var.theme.colors.c5;
      color6 = "#" + config.var.theme.colors.c6;
      color7 = "#" + config.var.theme.colors.c7;
      color8 = "#" + config.var.theme.colors.c8;
      color9 = "#" + config.var.theme.colors.c9;
      color10 = "#" + config.var.theme.colors.c10;
      color11 = "#" + config.var.theme.colors.c11;
      color12 = "#" + config.var.theme.colors.c12;
      color13 = "#" + config.var.theme.colors.c13;
      color14 = "#" + config.var.theme.colors.c14;
      color15 = "#" + config.var.theme.colors.c15;

      # Remote control
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
    };
    keybindings = {
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "ctrl+backspace" = "send_text all \\x17";
      "ctrl+delete" = "send_text all \\x1bd";
      "ctrl+f5" = "load_config_file";
      "ctrl+left" = "release ungrabbed mouse_handle_click link";

      ### Tab management
      "ctrl+t" = "new_tab";
      "ctrl+w" = "close_tab";
      "ctrl+shift+f2" = "set_tab_title";
      "ctrl+shift+d" = "new_tab_with_cwd";

      ### Scrolling
      "ctrl+u" = "scroll_page_up";
      "ctrl+d" = "scroll_page_down";

      ### Unbind
      "ctrl+shift+s" = "no_op";
      "left" = "click ungrabbed no_op";

      "f4" = "launch --location=split";
    };
  };
}
