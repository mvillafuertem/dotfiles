# Common configuration shared across all systems
{ user, pkgs, lib, ... }: {
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

  # Enable experimental features for nix commands.
  # Usamos mkDefault para que en darwin (donde nix-darwin gestiona `nix`
  # a nivel sistema y lo inyecta también en home-manager) no haya conflicto.
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = lib.mkDefault [ "nix-command" "flakes" ];
    };
  };
}

