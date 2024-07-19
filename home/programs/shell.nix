{ pkgs, lib, ... }:
let
  json2nix = pkgs.writeScriptBin "json2nix" # bash
    ''
      #! /usr/bin/env bash
      filename="$(basename "$0")-$(date +%s)-$(basename "$1")"
      cat "$1" | sed -e 's;//.*$;;g' > /tmp/"$filename"
      echo "$(nix eval --expr 'builtins.fromJSON (builtins.readFile /tmp/'"$filename"')' --impure | nixfmt)"
    '';
  toml2nix = pkgs.writeScriptBin "toml2nix" # bash
    ''
      #! /usr/bin/env bash
      filename="$(basename "$0")-$(date +%s)-$(basename "$1")"
      cat "$1" | sed -e 's;//.*$;;g' > /tmp/"$filename"
      echo "$(nix eval --expr 'builtins.fromTOML (builtins.readFile /tmp/'"$filename"')' --impure | nixfmt)"
    '';
in {
  # Custom scripts
  home.packages = [ json2nix toml2nix ];

  home.shellAliases = {
    # LS aliases
    ll = "eza -alF --git";
    ls = "eza --icons";
    la = "eza -a --icons";
    lt = "eza -T";
    le = "eza -alTL 2";

    # Easier navigation: .., ..., ...., ....., ~ and -
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";

    cls = "clear";
    # Reload aliases
    reload = "source ~/.config/fish/config.fish";
    udev-reload = "sudo udevadm control --reload-rules && sudo udevadm trigger";
    gpg-reload = "gpg-connect-agent reloadagent /bye";
    systemctl-reload = "sudo systemctl daemon-reload";
    sound-reload =
      "systemctl --user restart wireplumber pipewire pipewire-pulse";

    list-sound-cards = "cat /proc/asound/cards";
    logout = "loginctl terminate-user $USER";
    si = "su -s /bin/fish";
    tarnow = "tar -acf ";
    untar = "tar -xvf ";
    gzipnow = "tar czf";
    of = "onefetch";
    nf = "fastfetch";
    icat = "kitty +kitten icat";
    xterm-kitty = "kitty";
    n = "nvim";
    btc = "bluetoothctl";
    xo = "xdg-open";
    jctl = "journalctl -p 3 -xb";
    esudo = "sudoedit";
    passwdgen = "date +%s | sha256sum | base64 | head -c 64; echo";
    passgen = # fish
      ''
        strings /dev/urandom | grep -o '[^~`[:space:]]' | head -n 32 | tr -d "\n"
      '';
  };

  home.sessionVariables = {
    DIFFPROG = "delta";
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    GPG_TTY = "tty";
    GCC_COLORS =
      "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = # fish
      ''
        fastfetch
        set sponge_purge_only_on_exit true
        bind \cj history-search-forward
        bind \ck history-search-backward
        bind \cl forward-char
        bind \ch backward-char

        function last_history_item
          echo $history[1]
        end

        function last_history_item_args
          echo $history[1] | cut -f 2- -d " "
        end

        abbr -a !! --position anywhere --function last_history_item # Last command
        abbr -a \?\? --position anywhere --function last_history_item_args # Last command without the first word

        if [ "$TERM" = "linux" ] && type -q starship
          source (starship init fish --print-full-init | psub)
        else if type -q oh-my-posh
          oh-my-posh --init --shell fish --config '~/.config/oh-my-posh/kamack.omp.json' | source
        end
      '';
    functions = {
      dolp = # fish
        "command dolphin $path &> /dev/null & disown";
      fish_greeting = # fish
        "";
      ghget = {
        description = "Download file from github";
        body = # fish
          ''
            set -l url (echo $argv[1] | sed 's/https:\/\/github.com/https:\/\/raw.githubusercontent.com/' | sed 's/blob\///') 
            wget $url
          '';
      };
      cpf = {
        description = "Copy file contents to clipboard";
        argumentNames = "file_name";
        body = # fish
          ''cat "$file_name" | wl-copy'';
      };
      psf = {
        description = "Paste clipboard contents to file";
        argumentNames = "file_name";
        body = # fish
          "wl-paste > $file_name";
      };
      rm-except = {
        argumentNames = "file";
        description = "Remove all files except one";
        body = # fish
          ''rm -rf (ls | grep -v "$file")'';
      };
      ffmpeg-extract-audio = {
        description = "Extracts audio from video";
        argumentNames = [ "input_file" "output_file" ];
        body = # fish
          ''
            command ffmpeg -i "$input_file" -vn -f mp3 "$output_file"

          '';
      };
      ffmpeg-add-subs = {
        description = "Adds soft subtitles to selected video file";
        argumentNames = [ "video_file" "subtitles_file" "output_file" ];
        body = # fish
          ''

            if test -z "$video_file"
              echo "Video file not set"
              return 1
            end
            if test -z "$subtitles_file"
              echo "Subtitles file not set"
              return 1
            end
            if test -z "$output_file"
              echo "Output file not set"
              return 1
            end
            if test -z "$output_file"
              echo "Output file not set"
              return 1
            end
            command ffmpeg -i "$video_file" -i "$subtitles_file" -c copy -c:s mov_text -metadata:s:s:1 language=eng "$output_file"
          '';
      };
      tm = {
        description = "Shows math expression in terminal";
        argumentNames = [ "math" "output_file" ];
        body = # fish
          ''
            set file "/tmp/math1010.typ"
            echo -e "#set page(width: auto, height: auto, margin: 10pt)\n\$\n$math\n\$" > $file
            if test -z "$output_file"
              typst compile -f png "$file" /dev/stdout | icat
            else
              typst compile -f png "$file" "$output_file"
              icat "$output_file"
            end
          '';
      };
      mp = {
        argumentNames = "output_file";
        body = # fish
          ''
            tm (wl-paste) "$output_file"
          '';
      };
    };
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "master";
          sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
      {
        name = "sponge";
        src = pkgs.fetchFromGitHub {
          owner = "meaningful-ooo";
          repo = "sponge";
          rev = "master";
          sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
    ];
  };
  programs.eza.enable = true;
  programs.git.enable = true;
  programs.bat = {
    enable = true;
    config = { theme = "OneHalfDark"; };
  };
  programs.ripgrep.enable = true;
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      vim_keys = "True";
      update_ms = "100";
    };
  };
  programs.tealdeer = {
    enable = true;
    settings = {
      style = {
        command_name.foreground = "red";
        example_text.foreground = "green";
        example_code.foreground = "blue";
        example_variable = {
          foreground = "blue";
          underline = true;
        };
      };
      updates.auto_update = true;
    };
  };
  programs.jq.enable = true;
  programs.fd.enable = true;

  programs.fzf.enable = true;

}
