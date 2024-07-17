{ pkgs, config, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "${config.var.homeDirectory}/Music";
    playlistDirectory = "${config.var.homeDirectory}/Music/playlists";
  };
  services.mpd-mpris.enable = true;
  services.playerctld.enable = true;

  programs.cava.enable = true;
  programs.ncmpcpp.enable = true;

  home.packages = with pkgs; [ ffmpeg sptlrx ];
}
