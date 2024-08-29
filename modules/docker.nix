{ lib, config, ... }:
let cfg = config.modules.docker;
in {
  options.modules.docker = { enable = lib.mkEnableOption "Docker"; };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${config.var.username}.extraGroups = [ "docker" ];
    virtualisation.docker.storageDriver = lib.mkDefault "btrfs";
  };
}
