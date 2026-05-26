{
  description = "Flake for Scala Development";

  inputs.systems.url = "github:nix-systems/default";

  outputs =
    { systems, nixpkgs, ... }:
    {
      devShells = nixpkgs.lib.genAttrs (import systems) (
        system:
        let
          zuluOverlay = final: prev: {
            jdk17_headless = prev.jdk17_headless.overrideAttrs (old: {
              version = "17.0.19";
              src = prev.fetchurl {
                url = "https://cdn.azul.com/zulu/bin/zulu17.66.19-ca-jdk17.0.19-macosx_aarch64.tar.gz";
                hash = "sha256-8r1a+qqkwj60vyx4kTx+t9PSKORCCf/sZS+3I4ii8lw=";
                curlOpts = "-H Referer:https://www.azul.com/downloads/zulu/";
              };
              postUnpack = ''
                if [ -d "$sourceRoot/zulu-17.jdk/Contents" ] && [ ! -d "$sourceRoot/Contents" ]; then
                  mv "$sourceRoot/zulu-17.jdk/Contents" "$sourceRoot/"
                  if [ -d "$sourceRoot/zulu-17.jdk/_CodeSignature" ]; then
                    mv "$sourceRoot/zulu-17.jdk/_CodeSignature" "$sourceRoot/"
                  fi
                  rmdir "$sourceRoot/zulu-17.jdk" 2>/dev/null || true
                fi
              '';
            });
          };
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ zuluOverlay ];
          };
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
            -----END CERTIFICATE-----        '';
        in
        {
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
        }
      );
    };
}
