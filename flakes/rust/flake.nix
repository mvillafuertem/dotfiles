{
  description = "Flake for Rust Development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
          name = "rust";
          buildInputs = [ pkgs.scala ];
          shellHook = ''
            echo "Welcome to the Rust development shell!"
          '';
      };
    };
}
