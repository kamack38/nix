{ config, ... }: {
  # Icon file
  home.file."${config.var.homeDirectory}/.config/fastfetch/38.txt".text = ''
     $1

     ________  ________
    |\_____  \|\   __  \
    \|_____\  \ \  \|\  \
     \|______  \ \   __  \
      \| ____\  \ \  \|\  \
       \|\_______\ \_______\
        \|_______|\|_______|

  '';

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "~/.config/fastfetch/38.txt";
        type = "file";
        padding = { right = 3; };
        color = { "1" = "red"; };
      };
      display = {
        separator = "  ";
        color = { separator = "cyan"; };
      };
      modules = [
        {
          type = "title";
          color = {
            user = "blue";
            host = "blue";
          };
        }
        {
          type = "custom";
          format = "────────────────────────────────";
          outputColor = "cyan";
        }
        {
          type = "os";
          key = " ";
          keyColor = "yellow";
        }
        {
          type = "host";
          format = "{5} {2}";
          key = " ";
          keyColor = "magenta";
        }
        {
          type = "kernel";
          key = " ";
          keyColor = "red";
        }
        {
          type = "uptime";
          key = "祥";
          keyColor = "blue";
        }
        {
          type = "packages";
          key = " ";
          keyColor = "green";
        }
        {
          type = "shell";
          key = " ";
          keyColor = "blue";
        }
        {
          type = "memory";
          key = " ";
          keyColor = "magenta";
        }
        "break"
        "colors"
      ];
    };
  };
}
