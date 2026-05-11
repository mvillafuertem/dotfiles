{ user, pkgs, ... }:
let
  homeManagerModules = map (module: ../../modules/home-manager/${module}) [
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
  ##############################################################
  # Configuración a nivel darwin (homebrew, servicios, etc.)
  ##############################################################
  homebrew = {
    brews = [
    ];
    casks = [
      { name = "blackhole-16ch"; greedy = true; }
      { name = "claude"; greedy = true; }
      { name = "jetbrains-toolbox"; greedy = true; }
      { name = "obsidian"; greedy = true; }
      { name = "postman"; greedy = true; }
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
        awscli2
        colima
        docker
        claude-code
        docker-buildx
        docker-credential-helpers
        eza
        gh
        git-lfs
        jq
        kubectl
        nix
        nixfmt
        nodejs
        tmux
        opencode
        github-copilot-cli
        openfortivpn
        pam-reattach
        rustup
        saml2aws
        scalafmt
        skim
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
        wireguard-tools
      ];
    };
  };
}
