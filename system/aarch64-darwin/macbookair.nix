{ user, pkgs, ... }:
let
  darwinModules = map (module: ../../modules/darwin/${module}) [
    "homebrew.nix"
    "macos-dock.nix"
    "macos-finder.nix"
    "macos-keyboard-shortcuts.nix"
    "macos-power-management.nix"
    "macos-trackpad.nix"
    "macos-window-manager.nix"
    # "sketchybar.nix"
  ];
  homeManagerModules = map (module: ../../modules/home-manager/${module}) [
    "bash"
    # "direnv"
    "eza"
    "git"
    # "k9s"
    "nvim"
    # "sketchybar"
    "starship"
    "tmux"
    "wezterm"
  ];
in {
  imports = darwinModules;

  ##############################################################
  # Identidad de red de este host
  ##############################################################
  networking = {
    hostName = "macbookair";       # `hostname` (uso interno)
    computerName = "macbookair";   # nombre amigable (Ajustes → Acerca de)
    localHostName = "macbookair";  # nombre Bonjour: macbookair.local
  };

  ##############################################################
  # Configuración a nivel darwin (homebrew, servicios, etc.)
  ##############################################################
  homebrew = {
    brews = [
      # brews específicos de este host
    ];
    casks = [
      { name = "spotify"; greedy = true; }
      { name = "vnc-viewer"; greedy = true; }
    ];
  };

  ##############################################################
  # Configuración home-manager para este host/usuario
  ##############################################################
  home-manager.users.${user} = {
    imports = [ ../common.nix ] ++ homeManagerModules;

    home = {
      homeDirectory = "/Users/${user}";
      packages = with pkgs; [
        eza
        nix
        nixfmt
        tmux
        opencode
        pam-reattach
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
        wireguard-tools
      ];
    };
  };
}
