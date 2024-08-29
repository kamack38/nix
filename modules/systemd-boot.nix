{ lib, config, ... }:
let cfg = config.modules.systemd-boot;
in {
  options.modules.systemd-boot = {
    enable = lib.mkEnableOption "Enable systemd-boot bootloader";
  };

  config = lib.mkIf cfg.enable {
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.consoleMode = "max";
    boot.loader.efi.canTouchEfiVariables = true;
    boot.tmp.cleanOnBoot = true;
  };
}
