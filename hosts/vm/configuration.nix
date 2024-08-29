{ config, pkgs, inputs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  console = {
    earlySetup = true;
    keyMap = config.var.keyboardLayout;
    packages = with pkgs; [ terminus_font ];
    font = "ter-v20b";
    colors =
      (builtins.genList (x: config.var.theme.colors."c${toString x}") 16);
  };

  # Create users
  users.users.${config.var.username} = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs config; };
    useGlobalPkgs = true;
    users = { ${config.var.username} = import ./../../home; };
  };

  # Shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Set environment variables
  environment.sessionVariables = {
    FLAKE = "${config.var.homeDirectory}/dotfiles";
    NIXOS_OZONE_WL = "1";
  };

  # Install packages
  environment.systemPackages = with pkgs; [
    binutils
    spice-vdagent
    # spotifywm
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  modules = {
    desktop.enable = true;
    bluetooth.enable = true;
    systemd-boot.enable = true;
  };
  # services = {
  #   xserver = {
  #     enable = true;
  #     xkb.layout = config.var.keyboardLayout;
  #   };
  #
  #   displayManager = {
  #     sddm.enable = true;
  #
  #     # autoLogin = {
  #     #   enable = true;
  #     #   user = "${config.var.username}";
  #     # };
  #   };
  # };
  # environment.systemPackages = lib.mkMerge with pkgs; [ wayland-pipewire-idle-inhibit ];

  # hardware = {
  #   opengl = {
  #     enable = true;
  #     dirSupport = true;
  #     driSupport32Bit = true;
  #   };
  #   nvidia.modesetting.enable = true;
  #
  #   openrazer.enable = true;
  #
  #   # Move to gaming settings
  #   xpadneo.enable = true;
  # };
  services.libinput.enable = true;
  services.dbus.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
