{ pkgs, lib, config, ... }: {
  config = lib.mkIf config.desktop.enable {
    home.packages = with pkgs; [
      (discord.override { withOpenASAR = true; })
      xwaylandvideobridge
    ];
  };
}
