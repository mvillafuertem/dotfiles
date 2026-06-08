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
}
