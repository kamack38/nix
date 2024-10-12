{ pkgs, lib, config, ... }: {
  config = lib.mkIf config.desktop.enable {
    home.packages = with pkgs; [
      # File management
      dolphin
      ark
      gwenview
      libsForQt5.kimageformats

      # PDF Viewer
      okular
    ];
  };
}
