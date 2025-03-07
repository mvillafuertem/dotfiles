{
  description = "Flake for Scala Development";

  inputs.systems.url = "github:nix-systems/default";

  outputs = { systems, nixpkgs, ... }: {
    devShells = nixpkgs.lib.genAttrs (import systems) (system:
      let
        jdk = pkgs.openjdk8;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              sbt = prev.sbt.overrideAttrs {
                patchPhase = ''
                  echo -java-home ${jdk} >> conf/sbtopts
                '';
              };
            })
          ];
        };
      in {
        default = pkgs.mkShell {
          name = "scala";
          buildInputs = [ jdk pkgs.sbt pkgs.metals pkgs.figlet ];
          shellHook = ''
            [ ! -f /tmp/figlet/Shadow.flf ] &&\
            mkdir -p /tmp/figlet &&\
            curl -L https://raw.githubusercontent.com/xero/figlet-fonts/master/ANSI%20Shadow.flf > /tmp/figlet/Shadow.flf
            echo -e "\033[36m$(figlet -f "/tmp/figlet/Shadow.flf" "scala")\033[0m"
          '';
        };
      });
  };
}
