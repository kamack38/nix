{ ... }: {
  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      blocks = [
        {
          alignment = "left";
          newline = true;
          segments = [
            {
              background = "#18354F";
              foreground = "#d2ff5e";
              leading_diamond = "";
              properties = {
                alpine = "<#0D597F></>";
                arch = "<#1793d1></>";
                centos = "";
                debian = "<#A90232></>";
                elementary = "<#44A2E8></>";
                fedora = "<#072B61></>";
                gentoo = "<#61538D></>";
                linux = "<#F5C11B></>";
                macos = "";
                manjaro = "<#34BE5B></>";
                mint = "<#86BE43></>";
                opensuse = "<73BA25></>";
                raspbian = "<#C51A4A></>";
                ubuntu = "<#E95420></>";
                windows = "<#26C6DA></>";
              };
              style = "diamond";
              template = " {{ if .WSL }}<#26C6DA></>/{{ end }}{{.Icon}} ";
              type = "os";
            }
            {
              background = "#2e6f95";
              foreground = "#38DE21";
              powerline_symbol = "";
              properties = {
                home_icon = "";
                mapped_locations = {
                  "~/.config" = "";
                  "~/Desktop" = "";
                  "~/Documents" = "";
                  "~/Documents/CPlusPlus" = "";
                  "~/Documents/GitHUB" = "";
                  "~/Documents/cpp" = "";
                  "~/Downloads" = "";
                  "~/Music" = "";
                  "~/Pictures" = "";
                  "~/Videos" = "";
                };
                style = "full";
              };
              style = "powerline";
              type = "path";
            }
            {
              background = "#4ecdc4";
              background_templates = [
                "{{ if or (.Working.Changed) (.Staging.Changed) }}#EDC809{{ end }}"
                "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#F26D50{{ end }}"
                "{{ if gt .Ahead 0 }}#B56576{{ end }}"
                "{{ if gt .Behind 0 }}#6D597A{{ end }}"
              ];
              foreground = "#f7fff7";
              powerline_symbol = "";
              properties = {
                branch_icon = " ";
                fetch_stash_count = true;
                fetch_status = true;
                fetch_upstream_icon = true;
              };
              style = "powerline";
              type = "git";
            }
            {
              background = "#ffeb3b";
              foreground = "#193549";
              powerline_symbol = "";
              properties = { fetch_status = true; };
              style = "powerline";
              type = "svn";
            }
          ];
          type = "prompt";
        }
        {
          alignment = "right";
          segments = [
            {
              background = "#ffff66";
              foreground = "#111111";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              type = "root";
            }
            {
              background = "#689f63";
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              properties = { fetch_package_manager = true; };
              style = "powerline";
              template =
                "{{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{else}}  {{ end }}{{ .Full }}";
              type = "node";
            }
            {
              background = "#002e53";
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              template = " 🌊 {{ .Full }} ";
              type = "nx";
            }
            {
              background = "#2bb1ee";
              foreground = "#03589c";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              type = "dart";
            }
            {
              background = "#4063D8";
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              type = "php";
            }
            {
              background = "lightWhite";
              foreground = "blue";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              template = " R {{ .Full }} ";
              type = "r";
            }
            {
              background = "#c3002f";
              foreground = "#ffffff";
              powerline_symbol = "";
              style = "powerline";
              type = "angular";
            }
            {
              background = "#00acd7";
              foreground = "#111111";
              invert_powerline = true;
              powerline_symbol = "";
              properties = { fetch_version = true; };
              style = "powerline";
              type = "go";
            }
            {
              background = "#4063D8";
              foreground = "#111111";
              invert_powerline = true;
              powerline_symbol = "";
              properties = { fetch_version = true; };
              style = "powerline";
              type = "julia";
            }
            {
              background = "#ebcc34";
              foreground = "#000000";
              powerline_symbol = "";
              style = "powerline";
              type = "kubectl";
            }
            {
              background = "#FFDE57";
              foreground = "#4584B6";
              invert_powerline = true;
              powerline_symbol = "";
              properties = {
                display_mode = "files";
                fetch_version = true;
                fetch_virtual_env = false;
              };
              style = "powerline";
              type = "python";
            }
            {
              background = "#906cff";
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              type = "kotlin";
            }
            {
              background = "#4063D8";
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              type = "crystal";
            }
            {
              background = "#AE1401";
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              properties = {
                display_mode = "files";
                fetch_version = true;
              };
              style = "powerline";
              type = "ruby";
            }
            {
              background = "#29315A";
              foreground = "#E64747";
              invert_powerline = true;
              powerline_symbol = "";
              properties = { fetch_version = true; };
              style = "powerline";
              type = "java";
            }
            {
              background = "#4E2BCD";
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              properties = { fetch_version = true; };
              style = "powerline";
              type = "dotnet";
            }
            {
              background = "#99908a";
              foreground = "#193549";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              template = "  {{ .Full }} ";
              type = "rust";
            }
            {
              background = "#000080";
              foreground = "#fff";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              template = "  {{ .Full }} ";
              type = "lua";
            }
            {
              background = "#1E9748";
              foreground = "#E8EAEE";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              template = "  cmake {{ .Full }} ";
              type = "cmake";
            }
            {
              background = "#FEAC19";
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              properties = {
                display_mode = "files";
                fetch_version = false;
              };
              style = "powerline";
              type = "azfunc";
            }
            {
              background_templates = [
                ''{{if contains "default" .Profile}}#FFA400{{end}}''
                ''{{if contains "jan" .Profile}}#f1184c{{end}}''
              ];
              foreground = "#ffffff";
              invert_powerline = true;
              powerline_symbol = "";
              properties = { display_default = false; };
              style = "powerline";
              type = "aws";
            }
            {
              background = "#5c41e2";
              foreground = "#fefefe";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              type = "terraform";
            }
            {
              background = "#0077C2";
              foreground = "#FFFFFF";
              invert_powerline = true;
              powerline_symbol = "";
              style = "powerline";
              type = "shell";
            }
            {
              background = "#ffe66d";
              foreground = "#293241";
              invert_powerline = true;
              powerline_symbol = "";
              properties = { style = "austin"; };
              style = "powerline";
              type = "executiontime";
            }
            {
              background = "#3BD01D";
              background_templates = [ "{{ if gt .Code 0 }}#FF005D{{ end }}" ];
              foreground = "#d3d7cf";
              invert_powerline = true;
              powerline_symbol = "";
              properties = { always_enabled = true; };
              style = "diamond";
              template = " {{ if gt .Code 0 }}{{ else }}{{ end }} ";
              type = "exit";
            }
          ];
          type = "prompt";
        }
        {
          alignment = "left";
          newline = true;
          segments = [{
            foreground = "#3BD01D";
            style = "plain";
            template = "❯";
            type = "text";
          }];
          type = "prompt";
        }
        {
          alignment = "right";
          segments = [{
            background = "#1BD760";
            foreground = "#ffffff";
            leading_diamond = "";
            properties = { track_separator = " - "; };
            style = "diamond";
            trailing_diamond = "";
            type = "spotify";
          }];
          type = "rprompt";
        }
      ];
      console_title_template =
        "{{if .Root}}⚡ {{end}}{{ .Shell }} in {{ .Folder }}";
      final_space = true;
      osc99 = false;
      transient_prompt = {
        background = "transparent";
        foreground = "#ffffff";
        template = "<#3BD01D>❯</> ";
      };
      version = 2;
    };
  };
}
