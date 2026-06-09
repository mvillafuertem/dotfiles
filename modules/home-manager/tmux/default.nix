{ pkgs, lib, config, ... }:
let
  cfg = config.gbg-tmux;
in {
  options.gbg-tmux = {
    enableK9sContextMenu = lib.mkEnableOption "k9s context menu script";
    enableProjectPicker = lib.mkEnableOption "project picker script";
  };

  config = {
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
  xdg.configFile."tmux/k9s-context-menu.sh" = lib.mkIf cfg.enableK9sContextMenu {
    source = ./config/k9s-context-menu.sh;
    executable = true;
  };

  # Project picker invoked by `prefix + P` (see config/tmux.conf): fzf sobre ~/gbg.
  xdg.configFile."tmux/project-picker.sh" = lib.mkIf cfg.enableProjectPicker {
    source = ./config/project-picker.sh;
    executable = true;
  };

  # Sub-configs sourced by tmux.conf (split by concern)
  xdg.configFile."tmux/options.conf".source     = ./config/options.conf;
  xdg.configFile."tmux/keybindings.conf".source = ./config/keybindings.conf;
  xdg.configFile."tmux/plugins.conf".source     = ./config/plugins.conf;
  xdg.configFile."tmux/statusbar.conf".source   = ./config/statusbar.conf;
  xdg.configFile."tmux/style.conf".source       = ./config/style.conf;

  # Battery level as plain integer for status-right color comparisons.
  xdg.configFile."tmux/batt-level.sh" = {
    source = ./config/batt-level.sh;
    executable = true;
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      # tmuxPlugins.catppuccin
    ];
  };
};
}
