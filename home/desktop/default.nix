{ lib, config, ... }: {
  options.desktop.enable =
    lib.mkEnableOption "Enable desktop and graphical apps";

  # imports = lib.mkIf config.desktop.enable [
  #   ./waybar
  #   ./discord.nix
  #   ./dunst.nix
  #   ./firefox.nix
  #   ./hypridle.nix
  #   ./hyprland.nix
  #   ./hyprlock.nix
  #   ./hyprpaper.nix
  # ];
}
