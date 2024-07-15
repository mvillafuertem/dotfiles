{
  inputs = {
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  nixConfig = {
    extra-substituters = "https://nixpkgs-terraform.cachix.org";
    extra-trusted-public-keys =
      "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw=";
  };

  outputs = { self, nixpkgs-terraform, nixpkgs-python, nixpkgs, systems }:
    let forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in {
      devShells = forEachSystem (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          terraform = nixpkgs-terraform.packages.${system}."1.8.1";
          python = nixpkgs-python.packages.${system}."3.8";
        in {
          default = pkgs.mkShell {
            name = "devops";
            buildInputs = [
              terraform
              # python
              # pkgs.molecule
              pkgs.pyenv
              pkgs.crossplane
              pkgs.helmfile
              (pkgs.python3.withPackages
                (packages: with packages; [ 
                  virtualenv 
                  pip 
                  setuptools 
                  wheel
                  molecule
                ]))
              (pkgs.wrapHelm pkgs.kubernetes-helm {
                plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ];
              })
            ];
            shellHook = ''
              echo "Running hook"
              source <(helm completion bash)
              source <(helmfile completion bash)
              source <(pip completion --bash)
              echo "Helm:" $(helm version)
              echo "Helmfile:" $(helmfile version)
              echo "Molecule:" $(molecule --version)
            '';
          };
        });
    };
}
