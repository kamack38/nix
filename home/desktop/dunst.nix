{ ... }: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = "(111, 444)";
        height = 222;
        origin = "top-right";
        offset = "15 x25";
        scale = 0;
        notification_limit = 0;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 444;
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 5;
        padding = 15;
        horizontal_padding = 15;
        text_icon_padding = 0;
        frame_width = 0;
        frame_color = "#101419";
        separator_color = "frame";
        sort = "yes";
        font = "Iosevka Nerd Font 10";
        line_height = 0;
        markup = "full";
        format = ''
          <b>%s</b>
          %b'';
        alignment = "center";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "yes";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "no";
        icon_position = "left";
        icon_size = 48;
        max_icon_size = 80;
        corner_radius = 7;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        foreground = "#b6beca";
        background = "#101419bb";
        highlight = "#b6beca";
      };

      urgency_low.timeout = 4;
      urgency_normal.timeout = 6;
      urgency_critical.timeout = 10;
    };
  };
}
