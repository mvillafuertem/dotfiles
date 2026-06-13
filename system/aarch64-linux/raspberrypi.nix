# Linux-specific configuration for raspberry
{ lib, user, pkgs, ... }:
let
  homeManagerModules = map (module: ../../modules/home-manager/${module}) [
    "bash"
    "eza"
    "git"
    "labwc"
    "ssh"
    "lxterminal"
    "nvim"
    "nftables"
    "k3s"
    "opencode"
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

  home.activation.start-opencode-serve = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.systemd}/bin/systemctl --user is-active opencode-serve.service >/dev/null 2>&1 ||
      ${pkgs.systemd}/bin/systemctl --user start opencode-serve.service
  '';
}

