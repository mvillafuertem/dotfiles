# Darwin-specific configuration for GBMCRQ9PQTJF7K
{ user, pkgs, ... }:
let
  modules = map (module: ../../modules/home-manager/${module}) [
    "bash"
    "direnv"
    "eza"
    "git"
    "k9s"
    "karabiner"  # Darwin-only
    "nvim"
    "starship"
    "tmux"
    "wezterm"
  ];
in {
  imports = [ ../common.nix ] ++ modules;

  home = {
    homeDirectory = "/Users/${user}";
    # sessionPath = [ "${pkgs.git}/bin/aws_completer" ];
    # Darwin-specific packages
    packages = with pkgs; [
      # Then we add the packages we want in the array using pkgs.<name>
      awscli2
      # aerospace
      # nmap https://github.com/NixOS/nixpkgs/issues/333530#issuecomment-2325269416
      # ssm-session-manager-plugin
      # bash-completion
      # coursier
      # go
      colima
      docker
      docker-buildx
      docker-credential-helpers
      eza
      git-lfs
      jq
      kubectl
      nix
      nixfmt
      nodejs
      tmux
      openfortivpn
      pam-reattach
      rustup # rustup update
      saml2aws
      scalafmt
      skim
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      wireguard-tools
      # (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" ]; })
      # google-chrome https://github.com/NixOS/nixpkgs/pull/162467
    ];
  };
}

