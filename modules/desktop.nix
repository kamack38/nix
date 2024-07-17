{ inputs, lib, config, pkgs, ... }:
let
  cfg = config.virt;
  inherit (builtins) attrValues;
  inherit (config.var) username;
in {
  imports =
    attrValues { inherit (inputs.home-manager.nixosModules) home-manager; };
  options.desktop = { enable = lib.mkEnableOption "Desktop"; };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = { enable = true; };

      displayManager = {
        sddm.enable = true;

        autoLogin = {
          enable = true;
          user = username;
        };
      };
    };
    # environment.systemPackages = with pkgs; [
    #   wayland-pipewire-idle-inhibit
    #   firefox
    # ];
    home-manager.sharedModules =
      [{ wayland.windowManager.hyprland.enable = true; }];
  };
}
