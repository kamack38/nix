{ config, ... }: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = map ({ wallpaper }: wallpaper) config.var.theme.wallpapers;
      wallpaper = map ({ monitor, wallpaper }: "${monitor}, ${wallpaper}")
        config.var.theme.wallpapers;
    };
  };
}
