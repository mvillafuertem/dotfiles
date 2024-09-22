{
  inputs = {
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  nixConfig = {
    extra-substituters = "https://nixpkgs-terraform.cachix.org";
    extra-trusted-public-keys =
      "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw=";
  };

  outputs = { self, nixpkgs-terraform, nixpkgs-python, nixpkgs, systems }: {
    devShells = nixpkgs.lib.genAttrs (import systems) (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        terraform = nixpkgs-terraform.packages.${system}."1.9.5";
        python = nixpkgs-python.packages.${system}."3.8";
        # https://github.com/NixOS/nixpkgs/issues/217768#issuecomment-1672145841
        myhelm = with pkgs;
          wrapHelm kubernetes-helm {
            plugins = with pkgs.kubernetes-helmPlugins; [
              helm-diff
              helm-secrets
            ];
          };
        myhelmfile = pkgs.helmfile-wrapped.override {
          inherit (myhelm.passthru) pluginsDir;
        };
      in {
        default = pkgs.mkShell {
          name = "devops";
          buildInputs = [
            terraform
            pkgs.figlet
            # python
            # pkgs.molecule
            pkgs.pyenv
            pkgs.crossplane
            (pkgs.python3.withPackages (packages:
              with packages; [
                virtualenv
                pip
                setuptools
                wheel
                # molecule
              ]))
          ];
          nativeBuildInputs = [ myhelm myhelmfile ];

          shellHook = ''
            [ ! -f /tmp/figlet/Shadow.flf ] &&\
            mkdir -p /tmp/figlet &&\
            curl -L https://raw.githubusercontent.com/xero/figlet-fonts/master/ANSI%20Shadow.flf > /tmp/figlet/Shadow.flf
            echo -e "\033[36m$(figlet -f "/tmp/figlet/Shadow.flf" "devops")\033[0m"
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
