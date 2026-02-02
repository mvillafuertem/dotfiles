# We add pkgs since it's available as an argument, thanks to our inputs
{ user, pkgs, ... }: {
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "25.05";
    username = "${user}";
    homeDirectory = "/Users/${user}";
    # sessionPath = [ "${pkgs.git}/bin/aws_completer" ];
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
    # Tell it to map everything in the `config` directory in this
    # repository to the `.config` in my home directory
    # file.".config" = { 
    #   source = ./config; 
    #   recursive = true; 
    # };
    # file.".zprofile" = { source = ./.zprofile; };
    # file.".zshrc" = { source = ./.zshrc.bk; };
    file.".vimrc" = { source = ./modules/home-manager/nvim/config/vimrc; };
  };
  # This is to ensure programs are using ~/.config rather than
  # /Users/<username/Library/whatever
  xdg.enable = true;

  fonts.fontconfig.enable = true;
  #fonts.packages = with pkgs; [
  #  (nerdfonts.override { fonts = [ "Hack" "JetBrains Mono" ]; })
  #]; 

  programs.home-manager.enable = true;
  imports = [ ./modules/home-manager ];
  # I use zsh, but bash and fish work just as well here. This will setup
  # the shell to use home-manager properly on startup, neat!
  # programs.bash.enable = true;

}
