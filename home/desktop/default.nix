{ lib, config, ... }: {
  imports = [
    ./apps.nix
    ./waybar
    ./discord.nix
    ./dunst.nix
    ./firefox.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  options.desktop.enable =
    lib.mkEnableOption "Enable desktop and graphical apps";
}
