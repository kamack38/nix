{ config, lib, ... }: {
  config = lib.mkIf config.desktop.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = [ "--all" ];
      settings = {

        #### Monitor
        # See https://wiki.hyprland.org/Configuring/Monitors/
        monitor = ",highrr,auto,1";
      };
    };
  };
}
