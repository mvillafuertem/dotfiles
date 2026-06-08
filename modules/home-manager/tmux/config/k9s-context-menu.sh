#!/usr/bin/env bash
# k9s context picker for tmux. Bound to `prefix + K` (see tmux.conf).
# Lists kube contexts via kubectl; choosing one opens `k9s --context <ctx>`
# in a new tmux window. The list is built on each invocation, so it
# auto-updates as contexts are added/removed.

menu=()
i=1
while IFS= read -r ctx; do
  menu+=("$ctx" "$i" "new-window -n k9s 'k9s --context $ctx'")
  i=$((i + 1))
done < <(kubectl config get-contexts -o name 2>/dev/null)

if [ ${#menu[@]} -eq 0 ]; then
  tmux display-message "k9s: no kube contexts found (is kubectl configured?)"
  exit 0
fi

tmux display-menu -T "#[align=centre] k9s context " -x C -y C "${menu[@]}"
