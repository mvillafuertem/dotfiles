{ user, system, hostname, pkgs, ... }: {
  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.bashInteractive;
  };
  # Registra el bash de Nix en /etc/shells para que macOS lo acepte como
  # shell de login.
  environment.shells = [ pkgs.bashInteractive ];

  # Cambiar el shell de login del usuario al bash de Nix.
  # nix-darwin solo gestiona el UserShell para usuarios declarados en
  # `users.knownUsers` (que requiere uid/gid hardcoded). Para evitar eso,
  # lo aplicamos vía dscl en cada switch. Idempotente.
  system.activationScripts.postActivation.text = ''
    desired="/run/current-system/sw/bin/bash"
    current=$(/usr/bin/dscl . -read /Users/${user} UserShell 2>/dev/null | awk '{print $2}')
    if [ "$current" != "$desired" ]; then
      echo "Setting login shell for ${user} to $desired (was $current)"
      /usr/bin/dscl . -create /Users/${user} UserShell "$desired"
    fi

    # Marca el repo del flake como safe.directory para root, evitando el error
    # "repository path ... is not owned by current user" al ejecutar
    # darwin-rebuild con sudo.
    flake_repo="/Users/${user}/.dotfiles"
    if [ -d "$flake_repo/.git" ]; then
      /usr/bin/git config --system --get-all safe.directory 2>/dev/null \
        | grep -qx "$flake_repo" \
        || /usr/bin/git config --system --add safe.directory "$flake_repo"
    fi
  '';

  # NOTA: se intentó habilitar Touch ID para `su` vía environment.etc."pam.d/su"
  # con pam_tid + pam_reattach, pero macOS no lanza el prompt biométrico desde
  # el contexto setuid de `su`. Solución: usar directamente
  # `sudo darwin-rebuild` desde el usuario habitual (con NOPASSWD para las
  # operaciones de brew que requieren sudo en /Applications).
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit user system; };
    # Nota: la config home-manager por host vive dentro de
    # ./system/${system}/${hostname}.nix bajo `home-manager.users.${user}`
  };
  nixpkgs.hostPlatform = system;
  nix.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    interval.Day = 7;
    options = "--delete-older-than 30d";
  };
  # https://github.com/LnL7/nix-darwin/issues/1041
  services.karabiner-elements.enable = false;
  system.stateVersion = 5;
  system.primaryUser = "${user}";
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      minimize-to-application = false;
      expose-group-apps = true;
      tilesize = 36;
      orientation = "bottom";
    };
  };
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };
  security.sudo.extraConfig = ''
    ${user} ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/darwin-rebuild
    ${user} ALL=(ALL) NOPASSWD: /etc/profiles/per-user/${user}/bin/wg-quick
    ${user} ALL=(ALL) NOPASSWD: /etc/profiles/per-user/${user}/bin/wg
    # Requerido por Homebrew cask (mover/borrar/instalar apps en /Applications).
    # SETENV permite el `sudo -E` que usa brew internamente.
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
  # Los darwin modules ya no se importan en bloque: cada host elige los suyos
  # en `system/${system}/${hostname}.nix` mediante una lista `darwinModules`
  # (mismo patrón que `homeManagerModules`).
  imports = [
    ./system/${system}/${hostname}.nix
  ];
}
