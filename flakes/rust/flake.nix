{
  description = "Flake for Rust Development";

  # inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05"; };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      system = "aarch64-darwin";
      overlays = [ (import rust-overlay) ];
      pkgs = import nixpkgs { inherit system overlays; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "rust";
        buildInputs = [
          pkgs.solana-cli
          pkgs.rust-bin.stable.latest.default
        ];
        shellHook = ''
          echo "Welcome to the Rust development shell!"
        '';
      };
    };
}
