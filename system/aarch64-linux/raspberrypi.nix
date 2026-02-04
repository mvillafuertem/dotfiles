# Linux-specific configuration for raspberry
{ user, pkgs, ... }:
let
  modules = map (module: ../../modules/home-manager/${module}) [
    "bash"
    "eza"
    "git"
    "nvim"
    "starship"
    "tmux"
    # No wezterm, k9s - lightweight setup
  ];
in {
  imports = [ ../common.nix ] ++ modules;

  home = {
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      docker
      ollama
      eza
      nix
      nixfmt
      nodejs
      tmux
      rustup # rustup update
    ];
  };

  # Linux-specific configuration
  # Example: systemd.user.services.something = { ... };
}

