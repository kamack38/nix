{ inputs, lib, config, ... }:
let cfg = config.desktop;
in {
  options.desktop = { enable = lib.mkEnableOption "Desktop"; };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = { enable = true; };

      displayManager = { sddm.enable = true; };
    };
  };
}
