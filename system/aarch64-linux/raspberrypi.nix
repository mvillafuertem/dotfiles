# Linux-specific configuration for raspberry
{ user, pkgs, ... }:
let
  homeManagerModules = map (module: ../../modules/home-manager/${module}) [
    "bash"
    "eza"
    "git"
    "labwc"
    "lxterminal"
    "nvim"
    "starship"
    "tmux"
    "wf-panel-pi"
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
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
    ];
  };

  # Linux-specific configuration
  # Example: systemd.user.services.something = { ... };
}

