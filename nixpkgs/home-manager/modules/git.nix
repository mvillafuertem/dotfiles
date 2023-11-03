{ config, pkgs, lib, libs, ... }:
{
  programs.git = {
    enable = true;
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}