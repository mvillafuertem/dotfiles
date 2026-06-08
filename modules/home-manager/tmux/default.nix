{ pkgs, ... }: {
  # We render tmux.conf via `.text` so we can interpolate ${pkgs.bashInteractive}
  # into the default-shell/default-command lines. The interpolation needs Nix,
  # which a raw `source = ./config/tmux.conf` cannot provide.
  xdg.configFile."tmux/tmux.conf".text = ''
    ${builtins.readFile ./config/tmux.conf}

    # Append the shell pinning at the end so it overrides anything earlier.
    # ${pkgs.bashInteractive}/bin/bash resolves to a /nix/store path that
    # exists on nix-darwin, NixOS, and standalone home-manager on Linux,
    # and does not depend on the username.
    set -g default-shell   ${pkgs.bashInteractive}/bin/bash
    set -g default-command ${pkgs.bashInteractive}/bin/bash
  '';

  # k9s context picker invoked by `prefix + K` (see config/tmux.conf).
  xdg.configFile."tmux/k9s-context-menu.sh" = {
    source = ./config/k9s-context-menu.sh;
    executable = true;
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      # tmuxPlugins.catppuccin
    ];
  };
}
