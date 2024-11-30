{ java ? "jdk17_headless" }:

let
  jdk = pkgs.${java}.overrideAttrs (old: rec {
    installPhase = old.installPhase + ''
      ${pkgs.openjdk8}/bin/keytool -importcert -alias "investigate" -file ${investigateCert} -keystore $out/jre/lib/security/cacerts -storepass changeit -noprompt || \
      ${pkgs.openjdk8}/bin/keytool -importcert -alias "investigate" -file ${investigateCert} -keystore $out/lib/security/cacerts -storepass changeit -noprompt
    '';
  });

  config.packageOverrides = pkgs: rec {
    sbt = pkgs.sbt.override { jre = jdk; };
    metals = pkgs.metals.override { jre = jdk; };
    async-profiler = pkgs.async-profiler.override { jdk = jdk; };
  };

  pkgs = import <nixpkgs> { inherit config; };

  investigateCert = pkgs.writeText "investigate-ca.pem" ''
    -----BEGIN CERTIFICATE-----
    -----END CERTIFICATE-----
  '';

in pkgs.mkShell {

  buildInputs =
    [ jdk pkgs.sbt pkgs.grpcurl pkgs.metals pkgs.figlet pkgs.async-profiler ];

  shellHook = ''
    [ ! -f /tmp/figlet/Shadow.flf ] &&\
    mkdir -p /tmp/figlet &&\
    curl -L https://raw.githubusercontent.com/xero/figlet-fonts/master/ANSI%20Shadow.flf > /tmp/figlet/Shadow.flf
    echo -e "\033[36m$(figlet -w 130 -f "/tmp/figlet/Shadow.flf" "aggregator")\033[0m"
  '';

}
