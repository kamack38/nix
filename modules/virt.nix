{ lib, home-manager, config, ... }:
let cfg = config.modules.virt;
in {
  options.modules.virt = { enable = lib.mkEnableOption "Virtualisation"; };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.extraGroups.libvirtd.members = [ config.var.username ];
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
