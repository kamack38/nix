{ pkgs, ... }: {
  home.packages = with pkgs; [
    # File management
    dolphin
    ark
    gwenview
    libsForQt5.kimageformats

    # PDF Viewer
    okular
  ];
}
