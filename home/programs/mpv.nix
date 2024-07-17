{ pkgs, config, ... }: {
  programs.mpv = {
    enable = true;
    config = {
      # Cache
      cache = "yes";
      demuxer-max-bytes = "65536k";
      demuxer-readahead-secs = "9000";

      sub-file-paths = "./lyrics:./subs:./Subs:./*.srt";
      sub-auto = "fuzzy";

      # Switch to yt-dlp
      script-opts = "ytdl_hook-ytdl_path=yt-dlp";

      # Add new videos to playlist
      ytdl-raw-options = "yes-playlist=";

      # Uses GPU-accelerated video output by default.
      vo = "gpu";
      # Can cause performance problems with some drivers and GPUs.
      profile = "gpu-hq";
      # Disable OSC
      osc = "no";
      # Disable border
      border = "no";
      # Disable window grabbing
      # no-window-dragging
      # Snap window
      # snap-window

      # Save position on quit
      save-position-on-quit = "";
      # Change screenshot type
      screenshot-format = "png";
      # Change screenshot directory
      screenshot-directory = "~/Pictures/mpv";
      # Change template
      screenshot-template = "%f%n";
      osd-font = "Consolas";

      script-opts-add =
        "osc-title=\${media-title}\${?chapter-metadata/title: [\${chapter-metadata/title}]}";
    };
    profiles = {
      # Custom Profiles
      # Uses specific naming convensions for shorter easier typing.
      # Naming Convensions:
      # V = Very Low, L = Low, M = Medium, H = High, U = Ultra, S = Supreme
      # Very Low = 480p, Low = 720p, Medium = 1080p, High = 1440p, Ultra = 2160p (4), Supreme = 4320p (8K)
      # 30 = 30 frames per second, 60 = 60 frames per second
      # Use the switch e.g: --profile=H60
      # 4320p (8K) 60 FPS
      S60.ytdl-format =
        "bestvideo[height<=?4320][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      # 4320p (8K) 30 FPS
      S30.ytdl-format =
        "bestvideo[height<=?4320][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      # 2160p (4K) 60 FPS
      U60.ytdl-format =
        "bestvideo[height<=?2160][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      # 2160p (4K) 30 FPS
      U30.ytdl-format =
        "bestvideo[height<=?2160][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      # 1440p 60 FPS
      H60.ytdl-format =
        "bestvideo[height<=?1440][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      # 1440p 30 FPS
      H30.ytdl-format =
        "bestvideo[height<=?1440][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      # 1080p 60 FPS
      M60.ytdl-format =
        "bestvideo[height<=?1080][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      # 1080p 30 FPS
      M30.ytdl-format =
        "bestvideo[height<=?1080][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      # 720p 60 FPS
      L60.ytdl-format =
        "bestvideo[height<=?720][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      # 720p 30 FPS
      L30.ytdl-format =
        "bestvideo[height<=?720][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      # 480p 60 FPS
      V60.ytdl-format =
        "bestvideo[height<=?480][fps<=?60][vcodec!=?vp9]+bestaudio/best";
      # 480p 30 FPS
      V30.ytdl-format =
        "bestvideo[height<=?480][fps<=?30][vcodec!=?vp9]+bestaudio/best";
      # BEST video and audio
      BEST.ytdl-format =
        "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio";

      # File Type Profiles
      # Profile for images
      images = {
        profile-cond = ''
          (filename:match"%.jpg$" or filename:match"%.webp$" or filename:match"%.png$") ~= nil'';
        no-pause = "";
        loop-file = "yes";
      };
      # GIF Files
      "extension.gif" = {
        cache = "no";
        no-pause = "";
        loop-file = "yes";
      };
      # WebM Files
      "extension.webm" = {
        no-pause = "";
        loop-file = "yes";
      };
      idle = {
        profile-cond = ''p["idle-active"]'';
        profile-restore = "copy-equal";
        background-color = "#1B1E20";
      };
    };
    bindings = {
      RIGHT = "seek 5"; # seek 5 seconds forward
      LEFT = "seek -5"; # seek 5 seconds backward
      UP = "seek 60"; # seek 1 minute forward
      DOWN = "seek -60"; # seek 1 minute backward
      WHEEL_UP = "seek 10"; # seek 10 seconds forward
      WHEEL_DOWN = "seek -10"; # seek 10 seconds backward
      WHEEL_LEFT = "add volume -2"; # lower the volume
      WHEEL_RIGHT = "add volume 2"; # raise the volume
      q = "quit"; # exit
      CLOSE_WIN = "quit"; # exit
      "ctrl+w" = "quit"; # exit
      Q = "quit-watch-later"; # exit and remember the playback position
      j = "playlist-prev"; # skip to the previous file
      k = "playlist-next"; # skip to the next file
      s = "playlist-shuffle"; # shuffle playlist
      "ctrl+s" = "screenshot"; # screenshot
      # custom-osc.lua settings
      MBTN_LEFT = "script_message custom-osc-left-click";
      MBTN_LEFT_DBL = "script_message custom-osc-left-double-click";
      MBTN_RIGHT = "ignore";
      MOUSE_MOVE = "script_message custom-osc-mouse-move";
      # WHEEL_UP = "osd-msg add volume 10";
      # WHEEL_DOWN = "osd-msg add volume -10":

      F = "script-binding quality_menu/video_formats_toggle";
      "Alt+f" = "script-binding quality_menu/audio_formats_toggle";
    };
    scripts = with pkgs.mpvScripts; [
      mpris
      modernx
      mpv-cheatsheet
      mpv-playlistmanager
      quality-menu
      thumbfast
    ];
  };

  programs.yt-dlp = {
    enable = true;
    settings = {
      format = "mp4+m4a/bestvideo+bestaudio";
      output =
        "${config.var.homeDirectory}/Downloads/%(title)s-%(channel)s-%(resolution)s.%(ext)s";
      default-search = "ytsearch";
    };
  };
}
