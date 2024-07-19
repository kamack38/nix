{ config, pkgs, utils, ... }:
let inherit (utils) readFromDir;
in {
  imports = (readFromDir ./dev) ++ (readFromDir ./programs)
    ++ [ ../variables.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = config.var.username;
  home.homeDirectory = config.var.homeDirectory;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [ dolphin dust croc libqalculate qalculate-qt ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
