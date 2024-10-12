{ pkgs, config, lib, ... }: {
  config = lib.mkIf config.desktop.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      systemd.variables = [ "--all" ];
      settings = {

        #### Monitor
        # See https://wiki.hyprland.org/Configuring/Monitors/
        monitor = ",highrr,auto,1";
      };
    };
  };
}
