{
  description = "mvillafuerte's dotfiles";

  # inputs are other flakes you use within your own flake, dependencies
  # if you will
  inputs = {
    # unstable has the 'freshest' packages you will find, even the AUR
    # doesn't do as good as this, and it's all precompiled.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # In this context, outputs are mostly about getting home-manager what it
  # needs since it will be the one using the flake
  # Standalone home-manager configuration entrypoint
  # Available through 'home-manager --flake .#your-username@your-hostname'
  # darwin-rebuild build --flake .#simple
  outputs = { nixpkgs, home-manager, darwin, ... }:

    let
      user = "mvillafuerte";
      home = "/Users/${user}"; 
      system = "aarch64-darwin";
    in {

      darwinConfigurations = {
        ${user} = darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin.nix
            home-manager.darwinModules.home-manager
          ];
        };
      };

      homeConfigurations = {
        ${user} = home-manager.lib.homeManagerConfiguration {
          # darwin is the macOS kernel and aarch64 means ARM, i.e. apple silicon
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [ ./home.nix ];
        };
      };
    };
}
