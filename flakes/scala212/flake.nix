{
  description = "A basic flake for Scala development with SBT and Metals";

  inputs = {

    nixpkgs = {
      url = "github:NixOS/nixpkgs/5633bcff0c6162b9e4b5f1264264611e950c8ec7";
    };
    systems = { url = "github:nix-systems/default"; };

  };

  outputs = { systems, nixpkgs, ... }: {
    devShells = nixpkgs.lib.genAttrs (import systems) (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        metals212 = nixpkgs.legacyPackages.${system}.metals;
        # metals212 = import ./metals212.nix {
        #   inherit (pkgs) stdenv lib coursier makeWrapper setJavaClassPath;
        #   jre = pkgs.openjdk11;
        # };
        jdk = pkgs.jdk8.overrideAttrs (old: rec {
          installPhase = old.installPhase + ''
            ${pkgs.jdk8}/bin/keytool -importcert -alias "investigate" -file ${investigateCert} -keystore $out/jre/lib/security/cacerts -storepass changeit -noprompt || \
            ${pkgs.jdk8}/bin/keytool -importcert -alias "investigate" -file ${investigateCert} -keystore $out/lib/security/cacerts -storepass changeit -noprompt
          '';
        });

        # sbt = pkgs.sbt.override { jre = jdk; };
        sbt = pkgs.sbt.overrideAttrs (old: rec {
          patchPhase = ''
            echo -java-home ${jdk} >> conf/sbtopts
          '';
        });

        investigateCert = pkgs.writeText "investigate-ca.pem" ''
          -----BEGIN CERTIFICATE-----
          -----END CERTIFICATE-----
        '';
      in {
        default = pkgs.mkShell {
          name = "scala212";
          buildInputs = [
            (builtins.trace "jdk: ${toString jdk}" jdk)
            (builtins.trace "sbt: ${toString sbt}" sbt)
            (builtins.trace "metals: ${toString metals212}" metals212)
            (builtins.trace "figlet: ${toString pkgs.figlet}" pkgs.figlet)
          ];
          shellHook = ''
            [ ! -f /tmp/figlet/Shadow.flf ] &&\
            mkdir -p /tmp/figlet &&\
            curl -L https://raw.githubusercontent.com/xero/figlet-fonts/master/ANSI%20Shadow.flf > /tmp/figlet/Shadow.flf
            echo -e "\033[36m$(figlet -w 140 -f "/tmp/figlet/Shadow.flf" "scala212")\033[0m"
          '';
        };

      });
  };
}
