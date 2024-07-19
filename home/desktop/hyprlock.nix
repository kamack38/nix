{ ... }: {
  services.hypridle = {
    enable = true;
    settings = {
      "$wallpaper" = " ~/Pictures/Wallpapers/Green Leaf - Prateek Gautam.jpg";
      "$music" = "~/.config/hypr/scripts/playerctlock.sh";
      "$battery" = "~/.config/hypr/scripts/battery.sh";
      "$album" = "~/.config/hypr/scripts/hlock_mpris.sh";
      "$mpris_art" = "/tmp/hyde-mpris.png";

      # GENERAL
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = true;
      };

      # BACKGROUND
      background = [{
        monitor = "";
        path = "$wallpaper";
        blur_passes = 3;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      }];

      # INPUT FIELD
      input-field = [{
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.5)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = "false";
        placeholder_text =
          ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
        hide_input = false;
        position = "0, -120";
        halign = "center";
        valign = "center";
        check_color = "rgb(128, 237, 153)";
        fail_color = "rgb(229, 107, 111)";
      }];

      label = [
        # TIME
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +'%H:%M%p')"'';
          color = "$foreground";
          font_size = 120;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -300";
          halign = "center";
          valign = "top";
        }

        # USER
        {
          monitor = "";
          text = "Hi there, $USER";
          color = "$foreground";
          #color = rgba(255, 255, 255, 0.6);
          font_size = 25;
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }

        # BATTERY
        {
          monitor = "";
          text = ''cmd[update:10000] echo -e "$($battery)"'';
          color = "rgba(255, 255, 255, 1)";
          font_size = 12;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "-30, -510";
          halign = "right";
          valign = "center";
          zindex = 5;
        }
        # PLAYER TITLE
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$($music --title)"'';
          color = "rgba(255, 255, 255, 0.8)";
          font_size = 12;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "880, -310";
          halign = "left";
          valign = "center";
          zindex = 5;
        }

        # PLAYER LENGTH
        {
          monitor = "";
          text = "cmd[update:1000] $music --length";
          color = "rgba(255, 255, 255, 1)";
          font_size = 11;
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "-730, -332";
          halign = "right";
          valign = "center";
          zindex = 5;
        }

        # PLAYER STATUS
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$($music --status)"'';
          color = "rgba(255, 255, 255, 1)";
          font_size = 14;
          font_family = "JetBrains Mono Nerd Font Mono ";
          position = "-730, -310";
          halign = "right";
          valign = "center";
          zindex = 5;
        }

        # PLAYER SOURCE
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$($music --source)"'';
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 10;
          font_family = "JetBrains Mono Nerd Font Mono ";
          position = "880, -280";
          halign = "left";
          valign = "center";
          zindex = 5;
        }

        # PLAYER ARTIST
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$($music --artist)"'';
          color = "rgba(255, 255, 255, 0.8)";
          font_size = 10;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "880, -330";
          halign = "left";
          valign = "center";
          zindex = 5;
        }
      ];

      shape = [
        # BATTERY DIV
        {
          monitor = "";
          size = "70, 35";
          color = "rgba(18, 103, 55, 0.5)";
          rounding = 10;
          rotate = 0;
          position = "905, 12";
          halign = "center";
          valign = "bottom";
          zindex = 1;
        }

        # MUSIC BLUR DIV
        {
          monitor = "";
          size = "440, 110";
          color = "rgba(0, 0, 0, 0.5)";
          rounding = 20;
          rotate = 0;
          position = "30, -310";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
      ];

      image = [{
        # MUSIC ALBUM ART
        monitor = "";
        path = "$mpris_art";
        size = 80;
        rounding = 5;
        rotate = 0;
        reload_time = 0;
        reload_cmd = "";
        position = "-130, -310";
        halign = "center";
        valign = "center";
        zindex = 5;
      }];
    };
  };
}
