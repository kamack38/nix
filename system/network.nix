{ config, lib, ... }: {
  # Networking
  networking.hostName = config.var.hostname;
  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;
  users.extraGroups.networkmanager.members = [ config.var.username ];
}
