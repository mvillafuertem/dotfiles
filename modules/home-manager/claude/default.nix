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

  # Subagentes especializados: cuerpo compartido en ../../../agents (sin frontmatter);
  # aquí se envuelve con el frontmatter de Claude. Mismo patrón que @aact, para que el
  # mismo cuerpo sirva también en opencode (ver modules/home-manager/opencode).
  home.file.".claude/agents/tmux-expert.md".text = ''
    ---
    name: tmux-expert
    description: Experto en tmux (3.6a). Analiza y mejora la config de tmux del repo dotfiles (keybindings, status line, hooks, plugins TPM/catppuccin, copy-mode, sesiones, rendimiento). Conoce dónde vive la config y cómo aplicarla en caliente sin nix. Úsalo junto con uiux-expert.
    tools: Read, Grep, Glob, Edit, Bash, WebSearch, WebFetch
    model: inherit
    color: green
    ---

    ${builtins.readFile ../../../agents/tmux-expert.md}
  '';
  home.file.".claude/agents/uiux-expert.md".text = ''
    ---
    name: uiux-expert
    description: Experto en UI/UX de terminal (status lines, paletas, Nerd Font, jerarquía, contraste, responsive). Analiza y mejora el aspecto de la status line de tmux y su coherencia con la statusline de Claude. Conoce dónde vive la config y cómo probar en caliente sin nix. Úsalo junto con tmux-expert.
    tools: Read, Grep, Glob, Edit, Bash, WebSearch, WebFetch
    model: inherit
    color: purple
    ---

    ${builtins.readFile ../../../agents/uiux-expert.md}
  '';
  home.file.".claude/agents/nix-expert.md".text = ''
    ---
    name: nix-expert
    description: Experto en Nix (flakes, nixpkgs, home-manager, nix-darwin, módulos, overlays, derivaciones) con base sysadmin/SRE de la capa runtime que el config produce (launchd, systemd-user, permisos, macOS defaults). Diagnostica errores de evaluación/build y analiza/mejora código Nix con clean code adaptado al paradigma funcional (Uncle Bob, Fowler: SOLID, code smells, refactoring, DRY/YAGNI). Úsalo para depurar Nix, revisar calidad o refactorizar el repo dotfiles.
    tools: Read, Grep, Glob, Edit, Bash, WebSearch, WebFetch
    model: inherit
    color: blue
    ---

    ${builtins.readFile ../../../agents/nix-expert.md}
  '';
}
