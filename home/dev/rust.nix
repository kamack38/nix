{ pkgs, config, inputs, lib, ... }:
let cfg = config.rust;
in {
  options.rust = { enable = lib.mkEnableOption "Wakatime"; };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.fenix.overlays.default ];
    home.packages = with pkgs; [
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly
    ];
  };
}
