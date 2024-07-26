{ pkgs ? import (builtins.fetchTarball {
           name   = "nixos-fadaef5aedb6b35681248f8c6096083b2efeb284";
           url    = "https://github.com/NixOS/nixpkgs/archive/fadaef5aedb6b35681248f8c6096083b2efeb284.tar.gz";
           sha256 = "1if9fmx0zpx243jgp7vzkh6r5ai7ym8v7779yyq3x14bnqvax4fh";
         }) {} }:
let
  venvDirectory = ".venv";
  pythonPackages = pkgs.python310Packages;
in
  pkgs.mkShell rec {
    name = "ansible-andromeda-aws";
    venvDir = venvDirectory;
    buildInputs = [
      pythonPackages.python
      pythonPackages.venvShellHook
    ];
    postVenvCreation = ''
      pip install -r ./requirements.txt
      autoPatchelf ${venvDirectory}
    '';
    postShellHook = ''
      autoPatchelf ${venvDirectory}
    '';
  }
