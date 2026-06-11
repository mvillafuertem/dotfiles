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
    "whichspace"
  ];
  homeManagerModules = map (module: ../../modules/home-manager/${module}) [
    "bash"
    "claude"
    "direnv"
    "eza"
    "git"
    "k9s"
    "kube"
    "nvim"
    "ssh"
    "starship"
    "tmux"
    "wezterm"
  ];
in {
  imports = darwinModules;

  ##############################################################
  # Sudoers extra solo para este host (corporativo).
  # En este equipo el sudoers central restringe a `miguel.villafuerte`,
  # así que necesitamos NOPASSWD + SETENV para que `brew cask` pueda
  # operar sobre /Applications durante `darwin-rebuild switch`.
  # En otros Macs donde el usuario es admin pleno, NO se aplica esto y
  # sudo seguirá pidiendo Touch ID normalmente.
  ##############################################################
  security.sudo.extraConfig = ''
    ${user} ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild
    ${user} ALL=(ALL) NOPASSWD: /etc/profiles/per-user/${user}/bin/wg-quick
    ${user} ALL=(ALL) NOPASSWD: /etc/profiles/per-user/${user}/bin/wg
    # Requerido por Homebrew cask. SETENV permite el `sudo -E` interno de brew.
    ${user} ALL=(ALL) NOPASSWD: SETENV: /usr/bin/touch
    ${user} ALL=(ALL) NOPASSWD: SETENV: /bin/rm
    ${user} ALL=(ALL) NOPASSWD: SETENV: /bin/cp
    ${user} ALL=(ALL) NOPASSWD: SETENV: /bin/mv
    ${user} ALL=(ALL) NOPASSWD: SETENV: /bin/chmod
    ${user} ALL=(ALL) NOPASSWD: SETENV: /usr/sbin/chown
    ${user} ALL=(ALL) NOPASSWD: SETENV: /usr/sbin/installer
    ${user} ALL=(ALL) NOPASSWD: SETENV: /usr/bin/xattr
    ${user} ALL=(ALL) NOPASSWD: SETENV: /usr/bin/pkill
    ${user} ALL=(ALL) NOPASSWD: SETENV: /bin/launchctl
  '';

  ##############################################################
  # Configuración a nivel darwin (homebrew, servicios, etc.)
  ##############################################################

  ##############################################################
  # Hostname declarativo (DESHABILITADO — pendiente de hablar con IT).
  # Este Mac lo gestiona JAMF y la política MDM podría forzar el hostname
  # (el serial GBMCRQ9PQTJF7K). Para reaplicar "macbookpro" en cada
  # `darwin-rebuild switch`, añadir `hostname` a la firma del archivo:
  #   { user, hostname, pkgs, ... }:        # actualmente { user, pkgs, ... }
  # y descomentar (computerName + hostName cubren los tres scutil; el
  # localHostName hereda de hostName):
  #
  # networking.computerName = hostname;
  # networking.hostName     = hostname;
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

    gbg-tmux = {
      enableK9sContextMenu = true;
      enableProjectPicker = true;
    };

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
        fzf
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
        # skim # reemplazado por fzf (ver k9s-context-menu.sh)
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
        wireguard-tools
      ];
    };
  };
}
