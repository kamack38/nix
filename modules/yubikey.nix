{ pkgs, config, lib, ... }:
let cfg = config.modules.yubikey;
in {
  options.modules.yubikey.enable = lib.mkEnableOption "Enable Yubikey support";

  config = lib.mkIf cfg.enable {
    services.udev.packages = [ pkgs.yubikey-personalization ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    services.pcscd.enable = true;
  };
}
