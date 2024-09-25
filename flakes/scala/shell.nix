# nix-shell shell.nix --argstr java openjdk8 
{ java ? "openjdk8", ... }:

let
  pkgs = import <nixpkgs> { inherit config; };

  jdk = pkgs.${java};

  config = {
    packageOverrides = p: rec {
      sbt = p.sbt.overrideAttrs (
        old: rec {
          patchPhase = ''
            echo -java-home ${jdk} >> conf/sbtopts
          '';
        }
      );
    };
  };

in
  pkgs.mkShell {
    buildInputs = [
      jdk
      pkgs.sbt
    ];
  }

