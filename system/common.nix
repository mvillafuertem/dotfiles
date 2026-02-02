# Common configuration shared across all systems
{ user, pkgs, ... }: {
  home = {
    stateVersion = "25.05";
    username = "${user}";

    file.".vimrc" = { source = ../modules/home-manager/nvim/config/vimrc; };
  };

  # This is to ensure programs are using ~/.config rather than
  # /Users/<username>/Library/whatever
  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Enable experimental features for nix commands
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}

