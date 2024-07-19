{ config, ... }: {
  programs.ncmpcpp = {
    enable = true;
    settings = {
      lyrics_directory = "${config.var.homeDirectory}/Music/lyrics";
      mpd_crossfade_time = 5;
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "MPD Visualizer";
      visualizer_in_stereo = "yes";
      visualizer_type = "spectrum";
      visualizer_fps = 60;
      visualizer_autoscale = "yes";
      visualizer_spectrum_smooth_look = "yes";
      visualizer_spectrum_dft_size = 2;
      visualizer_spectrum_gain = 10;
      song_list_format = "$5{%t}|{%f} $9{$3$R %a} $9{$5$R  %l $9}";
      song_status_format =
        "{$2$b %t}|{%f}$/b$9 $b$2by$9$/b $2$b %a$/b$9 $b$2on$9$/b $2$b %b$/b$9";
      song_library_format = "{{%a - %t} (%b)}|{%f}";
      alternative_header_first_line_format =
        "$8 Now Playing:$9 $b$4{%t}|{%f}$/b$/b ";
      alternative_header_second_line_format =
        "{$b{$8by $9$4 %a$9}{ $8on$9 $4 %b$9}}";
      current_item_inactive_column_prefix = "$3 ";
      current_item_inactive_column_suffix = "$9";
      now_playing_prefix = "$4 $b";
      now_playing_suffix = "$/b$9";
      selected_item_prefix = "$7 ";
      selected_item_suffix = "$9";
      modified_item_prefix = "$3> $9";
      song_window_title_format = "{%a - }{%t}|{%f}";
      song_columns_list_format =
        "(60)[6]{t|f: Track} (35)[6]{ar: Artist} (5)[6]{lr:Time}";
      playlist_display_mode = "columns";
      browser_display_mode = "classic";
      search_engine_display_mode = "classic";
      playlist_editor_display_mode = "classic";
      show_duplicate_tags = "yes";
      seek_time = 1;
      volume_change_step = 2;
      progressbar_look = "━━";
      progressbar_color = "black";
      progressbar_elapsed_color = "blue";
      user_interface = "alternative";
      header_visibility = "no";
      statusbar_visibility = "yes";
      connected_message_on_startup = "no";
      titles_visibility = "yes";
      cyclic_scrolling = "no";
      #lyrics_fetchers = azlyrics, genius, musixmatch, sing365, metrolyrics, justsomelyrics, jahlyrics, plyrics, tekstowo, zeneszoveg, internet
      lyrics_fetchers = "musixmatch, tekstowo, internet";
      follow_now_playing_lyrics = "yes";
      fetch_lyrics_for_current_song_in_background = "no";
      store_lyrics_in_song_dir = "no";
      locked_screen_width_part = 40;
      jump_to_now_playing_song_at_start = "yes";
      clock_display_seconds = "no";
      display_volume_level = "yes";
      display_bitrate = "no";
      display_remaining_time = "no";
      empty_tag_marker = "<empty>";
      tags_separator = " | ";
      external_editor = "nvim";
      colors_enabled = "yes";
    };
    bindings = [
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "j";
        command = "scroll_down";
      }
    ];
  };

}
