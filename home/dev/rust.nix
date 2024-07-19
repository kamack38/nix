{ pkgs, inputs, ... }: {
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
}
