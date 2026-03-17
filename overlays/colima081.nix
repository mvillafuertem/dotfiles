# self: super:
# let
#   pkgs = import (builtins.fetchTarball {
#     # https://lazamar.co.uk/nix-versions/?package=go&version=1.20&fullName=go-1.20&keyName=go_1_20&revision=55070e598e0e03d1d116c49b9eff322ef07c6ac6&channel=nixpkgs-unstable#instructions
#     url =
#       "https://github.com/NixOS/nixpkgs/archive/55070e598e0e03d1d116c49b9eff322ef07c6ac6.tar.gz";
#     sha256 = "002wqi6wz795pzwlf0jp1z426mv3zfwx95zkk76y3zn87hll78kq";
#   }) { system = "aarch64-darwin"; };
# in {
#   colima081 = (super.colima.override {
#     buildGoModule = super.buildGoModule.override { go = pkgs.go_1_20; };
#   }).overrideAttrs (old: {
#     version = "0.8.1";
#     src = super.fetchFromGitHub {
#       inherit (old.src) owner repo;
#       rev = "v0.8.1";
#       sha256 = "sha256-RQnHqEabxyoAKr8BfmVhk8z+l5oy8pa5JPTWk/0FV5g=";
#     };
#     vendorHash = "sha256-rqCPpO/Va31U++sfELcN1X6oDtDiCXoGj0RHKZUM6rY=";
#   });
# }
