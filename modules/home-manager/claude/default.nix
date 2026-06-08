{ ... }: {
  # recursive = true es obligatorio: ~/.claude tiene contenido runtime
  # (sessions/, cache/, history.jsonl, ...). Con recursive home-manager crea
  # un symlink por archivo del source y deja el directorio padre escribible.
  home.file.".claude" = {
    source = ./config;
    recursive = true;
  };

  # Postura AACT (AI-Assisted Critical Thinking) always-on. La fuente única vive
  # en ../../../agents y la comparten Claude Code y opencode (sin duplicar).
  # Claude Code carga ~/.claude/CLAUDE.md en cada sesión, en todos los proyectos.
  home.file.".claude/CLAUDE.md".source = ../../../agents/aact.md;

  # Subagente @aact: revisión crítica profunda a demanda. El frontmatter es propio
  # de Claude; el cuerpo (prosa) se reusa de ../../../agents/aact-review.md.
  home.file.".claude/agents/aact.md".text = ''
    ---
    name: aact
    description: >-
      Pase de revisión crítica adversarial sobre una decisión, plan, diseño o
      argumento. Úsalo cuando el usuario pida "destroza esto", "qué me falta",
      "revisa esta decisión", o antes de una elección de alto riesgo o irreversible.
    tools: Read, Grep, Glob, Bash, WebSearch, WebFetch
    model: inherit
    color: red
    ---

    ${builtins.readFile ../../../agents/aact-review.md}
  '';

  # Subagentes especializados (fuente única en ../../../agents). Llevan su propio
  # frontmatter de Claude, así que se symlinkean directos.
  # @tmux-expert + @uiux-expert: analizan y mejoran la config de tmux (iteración en
  # caliente con `tmux source-file`, sin nix). Ver agents/{tmux,uiux}-expert.md.
  home.file.".claude/agents/tmux-expert.md".source = ../../../agents/tmux-expert.md;
  home.file.".claude/agents/uiux-expert.md".source = ../../../agents/uiux-expert.md;
}
