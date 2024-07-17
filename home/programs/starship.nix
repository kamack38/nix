{ ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      aws = { symbol = " "; };
      battery = {
        charging_symbol = "";
        disabled = true;
        discharging_symbol = "";
        display = [
          {
            disabled = false;
            style = "bold red";
            threshold = 15;
          }
          {
            disabled = true;
            style = "bold yellow";
            threshold = 50;
          }
          {
            disabled = true;
            style = "bold green";
            threshold = 80;
          }
        ];
        full_symbol = "";
      };
      character = {
        error_symbol = " [×](bold red)";
        success_symbol = " [╰─λ](bold red)";
      };
      cmd_duration = {
        disabled = false;
        format = "took [$duration]($style)";
        min_time = 1;
      };
      conda = { symbol = " "; };
      dart = { symbol = " "; };
      directory = {
        style = "purple";
        truncate_to_repo = true;
        truncation_length = 0;
        truncation_symbol = "repo: ";
      };
      docker_context = { symbol = " "; };
      elixir = { symbol = " "; };
      elm = { symbol = " "; };
      git_branch = { symbol = " "; };
      git_status = {
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        deleted = "x";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        style = "white";
      };
      golang = { symbol = " "; };
      hg_branch = { symbol = " "; };
      hostname = {
        disabled = false;
        format = "[$hostname]($style) in ";
        ssh_only = false;
        style = "bold dimmed red";
        trim_at = "-";
      };
      java = { symbol = " "; };
      julia = { symbol = " "; };
      nim = { symbol = " "; };
      nix_shell = { symbol = " "; };
      nodejs = { symbol = " "; };
      package = { symbol = " "; };
      perl = { symbol = " "; };
      php = { symbol = " "; };
      python = { symbol = " "; };
      ruby = { symbol = " "; };
      rust = { symbol = " "; };
      status = {
        disabled = false;
        format =
          "[\\[$symbol$status_common_meaning$status_signal_name$status_maybe_int\\]]($style)";
        map_symbol = true;
        pipestatus = true;
        symbol = "🔴";
      };
      sudo = { disabled = false; };
      swift = { symbol = "ﯣ "; };
      time = {
        disabled = true;
        format = " 🕙 $time($style)\n";
        style = "bright-white";
        time_format = "%T";
      };
      username = {
        format = " [╭─$user]($style)@";
        show_always = true;
        style_root = "bold red";
        style_user = "bold red";
      };
    };
  };
}
