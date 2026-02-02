# Linux-specific configuration for maximus
{ user, pkgs, ... }:
let
  modules = map (module: ../../modules/home-manager/${module}) [
    "bash"
    "direnv"
    "eza"
    "git"
    "k9s"
    "nvim"
    "starship"
    "tmux"
    "wezterm"
  ];
in {
  imports = [ ../common.nix ] ++ modules;

  home = {
    homeDirectory = "/home/${user}";

    # Linux-specific packages for maximus
    packages = with pkgs; [
      docker
      docker-buildx
      docker-credential-helpers
      # Add any maximus-specific packages here
    ];
  };

  # Linux-specific configuration
  # Example: systemd.user.services.something = { ... };
}

