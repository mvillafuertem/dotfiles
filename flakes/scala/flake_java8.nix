{
  description = "A basic flake for Scala development with SBT and Metals";

  inputs = {

    systems = { url = "github:nix-systems/default"; };

  };

  outputs = { systems, nixpkgs, ... }: {
    devShells = nixpkgs.lib.genAttrs (import systems) (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        jdk = pkgs.openjdk8.overrideAttrs (old: rec {
          installPhase = old.installPhase + ''
            ${pkgs.openjdk8}/bin/keytool -importcert -alias "investigate" -file ${cert} -keystore $out/jre/lib/security/cacerts -storepass changeit -noprompt || \
            ${pkgs.openjdk8}/bin/keytool -importcert -alias "investigate" -file ${cert} -keystore $out/lib/security/cacerts -storepass changeit -noprompt
          '';
        });

        sbt = pkgs.sbt.override { jre = jdk; };
        metals = pkgs.metals.override { jre = jdk; };
        # sbt = pkgs.sbt.overrideAttrs (old: rec {
        #   patchPhase = ''
        #     echo -java-home ${jdk} >> conf/sbtopts
        #   '';
        # });

        cert = pkgs.writeText "ca.pem" ''
          -----BEGIN CERTIFICATE-----
          -----END CERTIFICATE-----
        '';
      in {
        default = pkgs.mkShell {
          name = "flake-java-8";
          buildInputs = [
            (builtins.trace "jdk: ${toString jdk}" jdk)
            (builtins.trace "sbt: ${toString sbt}" sbt)
            (builtins.trace "metals: ${toString metals}" metals)
            (builtins.trace "figlet: ${toString pkgs.figlet}" pkgs.figlet)
          ];
          shellHook = ''
            [ ! -f /tmp/figlet/Shadow.flf ] &&\
            mkdir -p /tmp/figlet &&\
            curl -L https://raw.githubusercontent.com/xero/figlet-fonts/master/ANSI%20Shadow.flf > /tmp/figlet/Shadow.flf
            echo -e "\033[36m$(figlet -w 140 -f "/tmp/figlet/Shadow.flf" "flake-java-8")\033[0m"
          '';
        };

      });
  };
}
