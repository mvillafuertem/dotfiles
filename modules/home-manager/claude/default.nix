{ ... }: {
  # recursive = true es obligatorio: ~/.claude tiene contenido runtime
  # (sessions/, cache/, history.jsonl, ...). Con recursive home-manager crea
  # un symlink por archivo del source y deja el directorio padre escribible.
  home.file.".claude" = {
    source = ./config;
    recursive = true;
  };
}
