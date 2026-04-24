{
  description = "A basic flake for Scala development with SBT and Metals";

  inputs.systems.url = "github:nix-systems/default";

  outputs =
    { systems, nixpkgs, ... }:
    {
      devShells = nixpkgs.lib.genAttrs (import systems) (
        system:
        let
          zuluOverlay = final: prev: {
            jdk8 = prev.jdk8.overrideAttrs (old: {
              version = "8.0.492";
              src = prev.fetchurl {
                url = "https://cdn.azul.com/zulu/bin/zulu8.94.0.17-ca-jdk8.0.492-macosx_aarch64.tar.gz";
                hash = "sha256-c7hKv/DKShtki2zRI4EZRJa88x7gHyvdHtCRTJ7loVk=";
                curlOpts = "-H Referer:https://www.azul.com/downloads/zulu/";
              };
              postUnpack = ''
                # New Zulu tarballs have Contents/ directly in root instead of zulu-8.jdk/
                if [ -d "$sourceRoot/Contents" ] && [ ! -d "$sourceRoot/zulu-8.jdk" ]; then
                  mkdir -p "$sourceRoot/zulu-8.jdk"
                  mv "$sourceRoot/Contents" "$sourceRoot/zulu-8.jdk/"
                  if [ -d "$sourceRoot/_CodeSignature" ]; then
                    mv "$sourceRoot/_CodeSignature" "$sourceRoot/zulu-8.jdk/"
                  fi
                fi
              '';
            });
          };
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ zuluOverlay ];
          };
          metals212 = pkgs.metals;
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
        in
        {
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

        }
      );
    };
}
