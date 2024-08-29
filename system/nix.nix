{ lib, nixpkgs, ... }: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkForce true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  # Do garbage collection weekly
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Manual optimise storage: nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.channel.enable =
    false; # Remove nix-channel related tools & configs, we use flakes instead.

  # Make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  nix.registry.nixpkgs.flake = nixpkgs;
}
