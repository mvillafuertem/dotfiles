{ ... }: {
  home.file.".local/bin/opencode-serve.sh" = {
    source = ./opencode-serve.sh;
    executable = true;
  };
  home.file.".config/systemd/user/opencode-serve.service".source = ./opencode-serve.service;
  home.file.".config/opencode/tui.json".source = ./tui.json;

  # Postura AACT (AI-Assisted Critical Thinking) always-on. Misma fuente única que
  # Claude Code (../../../agents). opencode carga ~/.config/opencode/AGENTS.md como
  # instrucciones globales en cada sesión.
  home.file.".config/opencode/AGENTS.md".source = ../../../agents/aact.md;

  # Subagente aact: revisión crítica profunda a demanda. Frontmatter propio de
  # opencode; el cuerpo se reusa de ../../../agents/aact-review.md.
  home.file.".config/opencode/agents/aact.md".text = ''
    ---
    description: >-
      Pase de revisión crítica adversarial sobre una decisión, plan o argumento.
      Úsalo para "destroza esto", "qué me falta" o antes de una elección de alto riesgo.
    mode: subagent
    temperature: 0.2
    ---

    ${builtins.readFile ../../../agents/aact-review.md}
  '';

  # Subagentes especializados: mismo cuerpo compartido que Claude (../../../agents),
  # envuelto aquí con el frontmatter de opencode. Editar el cuerpo cambia ambas herramientas.
  home.file.".config/opencode/agents/tmux-expert.md".text = ''
    ---
    description: Experto en tmux (3.6a). Analiza y mejora la config de tmux del repo dotfiles (keybindings, status line, hooks, plugins, copy-mode, sesiones). Conoce dónde vive la config y cómo aplicarla en caliente sin nix. Úsalo junto con uiux-expert.
    mode: subagent
    temperature: 0.2
    ---

    ${builtins.readFile ../../../agents/tmux-expert.md}
  '';
  home.file.".config/opencode/agents/uiux-expert.md".text = ''
    ---
    description: Experto en UI/UX de terminal (status lines, paletas, Nerd Font, jerarquía, contraste, responsive). Analiza y mejora el aspecto de la status line de tmux y su coherencia con la statusline de Claude. Úsalo junto con tmux-expert.
    mode: subagent
    temperature: 0.2
    ---

    ${builtins.readFile ../../../agents/uiux-expert.md}
  '';
  home.file.".config/opencode/agents/nix-expert.md".text = ''
    ---
    description: Experto en Nix (flakes, nixpkgs, home-manager, nix-darwin, módulos, overlays) con base sysadmin/SRE de la capa runtime que el config produce. Diagnostica errores eval/build y analiza/mejora código Nix con clean code adaptado al paradigma funcional (Uncle Bob, Fowler). Úsalo para depurar Nix, revisar calidad o refactorizar el repo dotfiles.
    mode: subagent
    temperature: 0.2
    ---

    ${builtins.readFile ../../../agents/nix-expert.md}
  '';
}
