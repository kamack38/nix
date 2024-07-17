{ config, lib, ... }: {
  config = lib.mkIf config.desktop.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        decoration = {
          shadow_offset = "0 5";
          "col.shadow" = "rgba(00000099)";
        };

        "$mod" = "SUPER";

        bind = [ "$mod, grave, exec, kitty" ];

        bindm = [
          # mouse movements
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];
      };
    };
  };
}
