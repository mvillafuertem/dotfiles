# Linux-specific configuration for raspberry
{ user, pkgs, ... }:
let
  homeManagerModules = map (module: ../../modules/home-manager/${module}) [
    "bash"
    "eza"
    "git"
    "nvim"
    "starship"
    "tmux"
    # No wezterm, k9s - lightweight setup
  ];
in {
  imports = [ ../common.nix ] ++ homeManagerModules;

  home = {
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
     # docker
      opencode
      nmap
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

