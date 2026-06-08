#!/usr/bin/env bash
# k9s context picker for tmux. Bound to `prefix + K` (see tmux.conf), which
# runs this inside a tmux popup. Fuzzy-filter a kube context, then open
# `k9s --context <ctx>` in a new tmux window. The list is built on each
# invocation, so it auto-updates as contexts are added/removed.
#
# Prefers fzf; falls back to skim (sk) if fzf isn't installed (e.g. before a
# rebuild, or on a host without fzf).

picker=fzf
command -v fzf >/dev/null 2>&1 || picker=sk

ctx=$(kubectl config get-contexts -o name 2>/dev/null \
  | "$picker" --reverse --prompt 'k9s context> ' --no-multi)

# Sin -n: la ventana se autorenombra por el comando (k9s) vía automatic-rename-format
# en tmux.conf, que le pone el icono ☸/kube igual que claude/opencode.
[ -n "$ctx" ] && tmux new-window "k9s --context $ctx"
