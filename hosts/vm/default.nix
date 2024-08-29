{ config, nixpkgs, system, inputs, ... }:
with nixpkgs;
lib.nixosSystem rec {
  inherit system;

  specialArgs = { inherit inputs; };
  modules = [
    { nixpkgs = { inherit config; }; }
    ./../../variables.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.default
    (import ./disko-config.nix { device = "/dev/vda"; })
    ./configuration.nix

    ./../../modules
    # ../../system
    ./configuration.nix

  ];
}
