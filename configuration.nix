{ config, pkgs, inputs, lib, ... }:
let
  utils = import ./utils.nix;
  readFromDir = utils.readFromDir;
in {
  imports = [
    ./hardware-configuration.nix
    ./variables.nix
    inputs.home-manager.nixosModules.default
  ] ++ (readFromDir ./modules) ++ (readFromDir ./system);

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  # Networking
  networking.hostName = config.var.hostname;
  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;

  # Time zone and locale
  time.timeZone = config.var.timeZone;
  i18n.defaultLocale = config.var.defaultLocale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = config.var.extraLocale;
    LC_IDENTIFICATION = config.var.extraLocale;
    LC_MEASUREMENT = config.var.extraLocale;
    LC_MONETARY = config.var.extraLocale;
    LC_NAME = config.var.extraLocale;
    LC_NUMERIC = config.var.extraLocale;
    LC_PAPER = config.var.extraLocale;
    LC_TELEPHONE = config.var.extraLocale;
    LC_TIME = config.var.extraLocale;
  };

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
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
    shell = pkgs.fish;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { ${config.var.username} = import ./home; };
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
    neovim
    binutils
    spice-vdagent
    # spotifywm
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  desktop.enable = true;
  bluetooth.enable = true;
  services = {
    xserver = { enable = true; };

    displayManager = {
      sddm.enable = true;

      # autoLogin = {
      #   enable = true;
      #   user = "${config.var.username}";
      # };
    };
  };
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
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;
  services.libinput.enable = true;
  services.dbus.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
