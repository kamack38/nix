{ inputs, lib, config, ... }:
let
  cfg = config.virt;
  inherit (builtins) attrValues;
in {
  imports =
    attrValues { inherit (inputs.home-manager.nixosModules) home-manager; };
  options.virt = { enable = lib.mkEnableOption "Virtualisation"; };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    home-manager.sharedModules = [{
      dconf = {
        enable = true;
        settings = {
          "org/virt-manager/virt-manager/connections" = {
            autoconnect = [ "qemu:///system" ];
            uris = [ "qemu:///system" ];
          };
        };
      };
    }];
  };
}
