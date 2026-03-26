{
  # sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch  --flake ~/.dotfiles
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
    scala212 = {
      url = "./flakes/scala212";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    rust = {
      url = "./flakes/rust";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # nixConfig = {
  #   substituters = [ "https://cache.nixos.org" ];
  #   trusted-public-keys = [ ];
  # };

  # In this context, outputs are mostly about getting home-manager what it
  # needs since it will be the one using the flake
  # Standalone home-manager configuration entrypoint
  # Available through 'home-manager --flake .#your-username@your-hostname'
  # darwin-rebuild build --flake .#simple
  outputs = { nixpkgs, home-manager, darwin, devops, scala, scala212, rust, ... }:

    let
      inherit (builtins) readDir attrNames elem;
      inherit (nixpkgs.lib) mapAttrsToList filterAttrs hasSuffix getName;

      users = [
        {
          user = "maximus";
          hostname = "raspberrypi";
          system = "aarch64-linux";
        }
        {
          user = "miguel.villafuerte";
          hostname = "GBMCRQ9PQTJF7K";
          system = "aarch64-darwin";
        }
        {
          user = "maximus";
          hostname = "maximus";
          system = "aarch64-linux";
        }
      ];

      # importFrom = path: filename: import (path + ("/" + filename));
      # importOverlay = filename: _: importFrom ./overlays filename;
      # regularOverlays =
      #   filterAttrs (name: _: hasSuffix ".nix" name) (readDir ./overlays);
      # overlays = mapAttrsToList importOverlay regularOverlays;
      overlays = map (name: import ./overlays/${name}) (attrNames
        (filterAttrs (name: _: hasSuffix ".nix" name) (readDir ./overlays)));

      mkPkgs = system:
        import nixpkgs {
          inherit system overlays;
          config = {
            allowUnfreePredicate = pkg:
              elem (getName pkg) [ "github-copilot-cli" ]; # [ "google-chrome" "obsidian" ];
          };
        };

      mkDarwinConfig = cfg: {
        name = cfg.hostname;
        value = darwin.lib.darwinSystem {
          inherit (cfg) system;
          pkgs = mkPkgs cfg.system;
          specialArgs = {
            inherit (cfg) user system hostname; # Pasamos los valores como atributos
            pkgs = mkPkgs cfg.system;
          };
          modules = [ ./darwin.nix home-manager.darwinModules.home-manager ];
        };
      };

      mkHomeConfig = cfg: {
        name = cfg.hostname;
        value = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs cfg.system;
          extraSpecialArgs = {
            inherit (cfg) user system; # Pasamos los valores como atributos
          };
          modules = [ ./system/${cfg.system}/${cfg.hostname}.nix ];
        };
      };

      # Filtrar usuarios por tipo de sistema
      darwinUsers = builtins.filter (cfg: hasSuffix "-darwin" cfg.system) users;
      linuxUsers = builtins.filter (cfg: hasSuffix "-linux" cfg.system) users;

      mkDevShell = system: {
        default = devops.devShells.${system}.default;
        devops = devops.devShells.${system}.default;
        rust = rust.devShells.${system}.default;
        scala = scala.devShells.${system}.default;
        scala212 = scala212.devShells.${system}.default;
      };

    in {
      darwinConfigurations = builtins.listToAttrs (map mkDarwinConfig darwinUsers);
      homeConfigurations = builtins.listToAttrs (map mkHomeConfig linuxUsers);

      # https://discourse.nixos.org/t/making-globally-available-devshells/24913/4
      # nix develop ~/.dotfiles/flake.nix#devops
      # echo "use flake ~/.dotfiles/flake.nix#devops" > .direnv
      devShells = builtins.listToAttrs (map (cfg: {
        name = cfg.system;
        value = mkDevShell cfg.system;
      }) users);

    };
}
