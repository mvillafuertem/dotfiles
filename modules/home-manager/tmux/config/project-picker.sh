#!/usr/bin/env bash
# Project picker for tmux. Bound to `prefix + P` (see tmux.conf), which runs
# this inside a tmux popup. Fuzzy-filter a project under ~/gbg, then open a new
# tmux window already cd'd into it. The list is rebuilt on each invocation, so
# it auto-updates as projects are added/removed.
#
# Prefers fzf; falls back to skim (sk) if fzf isn't installed (e.g. on a host
# without fzf). `find -exec basename` is used (portable on macOS/BSD and Linux);
# GNU-only `-printf` is intentionally avoided.

projects_dir="$HOME/gbg"
[ -d "$projects_dir" ] || exit 0

picker=fzf
command -v fzf >/dev/null 2>&1 || picker=sk

project=$(find "$projects_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; \
  | sort \
  | "$picker" --reverse --prompt 'project> ' --no-multi)

# -c fija el directorio de inicio de la ventana nueva (equivale a cd ~/gbg/<project>).
[ -n "$project" ] && tmux new-window -c "$projects_dir/$project"
