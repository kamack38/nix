{
  # https://github.com/kamack38/nixos
  description = ''
    This is my NixOS configuration with home-manager.
  '';

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          inputs.disko.nixosModules.default
          inputs.home-manager.nixosModules.default
          (import ./disko-config.nix { device = "/dev/vda"; })
          ./configuration.nix
        ];
      };
      # iso = {
      #   system = "x86_64-linux";
      #   specialArgs = { inherit inputs; };
      #   modules = [
      #     (nixpkgs
      #       + "/nixos/modules//installer/cd-dvd/installation-cd-minimal.nix")
      #     inputs.home-manager.nixosModules.default
      #     ./configuration.nix
      #   ];
      # };
    };
  };
}
