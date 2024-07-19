{ inputs, lib, config, utils, ... }:
let
  cfg = config.virt;
  inherit (builtins) attrValues;
  inherit (utils) readFromDir;
in {
  imports =
    attrValues { inherit (inputs.home-manager.nixosModules) home-manager; };
  options.desktop = { enable = lib.mkEnableOption "Desktop"; };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = { enable = true; };

      displayManager = {
        sddm.enable = true;

        # autoLogin = {
        #   enable = true;
        #   user = username;
        # };
      };
    };

    home-manager.sharedModules = import readFromDir ../home/desktop;
  };
}
