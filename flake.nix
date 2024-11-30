{
  # nix-shell -p nix-info --run "nix-info -m"
  description = "mvillafuerte's dotfiles";

  # inputs are other flakes you use within your own flake, dependencies
  # if you will
  inputs = {
    # unstable has the 'freshest' packages you will find, even the AUR
    # doesn't do as good as this, and it's all precompiled.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/24.11-beta";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devops = {
      url = "./flakes/devops";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scala = {
      url = "./flakes/scala";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust = {
      url = "./flakes/rust";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # In this context, outputs are mostly about getting home-manager what it
  # needs since it will be the one using the flake
  # Standalone home-manager configuration entrypoint
  # Available through 'home-manager --flake .#your-username@your-hostname'
  # darwin-rebuild build --flake .#simple
  outputs = { nixpkgs, home-manager, darwin, devops, scala, rust, ... }:

    let
      inherit (builtins) readDir;
      inherit (nixpkgs.lib) mapAttrsToList filterAttrs hasSuffix;

      user = "mvillafuerte";
      home = "/Users/${user}";
      system = "aarch64-darwin";

      importFrom = path: filename: import (path + ("/" + filename));
      importOverlay = filename: _: importFrom ./overlays filename;
      regularOverlays =
        filterAttrs (name: _: hasSuffix ".nix" name) (readDir ./overlays);

      pkgs = import nixpkgs {
        system = system;
        overlays = mapAttrsToList importOverlay regularOverlays;
      };
    in {

      darwinConfigurations = {
        ${user} = darwin.lib.darwinSystem {
          inherit system pkgs;
          modules = [ ./darwin.nix home-manager.darwinModules.home-manager ];
        };
      };

      homeConfigurations = {
        ${user} = home-manager.lib.homeManagerConfiguration {
          # darwin is the macOS kernel and aarch64 means ARM, i.e. apple silicon
          inherit system pkgs;
          modules = [ ./home.nix ];
        };
      };

      # https://discourse.nixos.org/t/making-globally-available-devshells/24913/4
      # nix develop ~/.dotfiles/flake.nix#devops
      # echo "use flake ~/.dotfiles/flake.nix#devops" > .direnv
      devShells.${system} = {
        default = devops.devShells.${system}.default;
        devops = devops.devShells.${system}.default;
        rust = rust.devShells.${system}.default;
        scala = scala.devShells.${system}.default;
      };
    };
}
