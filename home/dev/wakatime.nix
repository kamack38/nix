{ config, pkgs, lib, ... }:
let cfg = config.wakatime;
in {
  options.wakatime = { enable = lib.mkEnableOption "Wakatime"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (writeShellScriptBin "wakatime"
        "exec -a $0 ${wakatime}/bin/wakatime-cli $@")
      wakatime
    ];

    programs.fish = {
      plugins = [{
        name = "wakatime";
        src = pkgs.fishPlugins.wakatime-fish.src;
      }];
    };
  };
}
