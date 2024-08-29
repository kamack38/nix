{ inputs, lib, config, ... }:
let cfg = config.modules.desktop;
in {
  options.modules.desktop = { enable = lib.mkEnableOption "Enable desktop"; };

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;

    environment.variables.NIXOS_OZONE_WL = "1";

    services = {
      xserver = {
        enable = true;
        xkb.layout = config.var.keyboardLayout;
      };

      displayManager = {
        sddm.enable = true;

        # autoLogin = {
        #   enable = true;
        #   user = username;
        # };
      };
    };
  };
}
