{
  description = "Flake for Scala Development";

  inputs.systems.url = "github:nix-systems/default";

  outputs = { systems, nixpkgs, ... }: {
    devShells = nixpkgs.lib.genAttrs (import systems) (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        jdk = pkgs.jdk17_headless.overrideAttrs (old: rec {
          installPhase = old.installPhase + ''
            ${pkgs.jdk17_headless}/bin/keytool -importcert -alias "investigate" -file ${investigateCert} -keystore $out/jre/lib/security/cacerts -storepass changeit -noprompt || \
            ${pkgs.jdk17_headless}/bin/keytool -importcert -alias "investigate" -file ${investigateCert} -keystore $out/lib/security/cacerts -storepass changeit -noprompt
          '';
        });
        sbt = pkgs.sbt.overrideAttrs (old: rec {
          patchPhase = ''
            echo -java-home ${jdk} >> conf/sbtopts
          '';
        });

        coursier = pkgs.coursier;
        metals = pkgs.metals.override { jre = jdk; };
        # sbt = pkgs.sbt.overrideAttrs (old: rec {
        #   patchPhase = ''
        #     echo -java-home ${jdk} >> conf/sbtopts
        #   '';
        # });
        investigateCert = pkgs.writeText "investigate-ca.pem" ''
          -----BEGIN CERTIFICATE-----
          -----END CERTIFICATE-----
        '';
      in {
        default = pkgs.mkShell {
          name = "scala";
          buildInputs = [
            (builtins.trace "jdk: ${toString jdk}" jdk)
            (builtins.trace "sbt: ${toString sbt}" sbt)
            (builtins.trace "metals: ${toString metals}" metals)
            (builtins.trace "coursier: ${toString pkgs.coursier}" pkgs.coursier)
            (builtins.trace "figlet: ${toString pkgs.figlet}" pkgs.figlet)
            # pkgs.gitversion
          ];
          shellHook = ''
            [ ! -f /tmp/figlet/Shadow.flf ] &&\
            mkdir -p /tmp/figlet &&\
            curl -L https://raw.githubusercontent.com/xero/figlet-fonts/master/ANSI%20Shadow.flf > /tmp/figlet/Shadow.flf
            echo -e "\033[36m$(figlet -f "/tmp/figlet/Shadow.flf" "scala")\033[0m"
            echo $JAVA_HOME
          '';
        };
      });
  };
}
