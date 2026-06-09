#!/bin/sh
# Pane pty → tmux bell-action any forwards to WezTerm as pane bell
# audible_bell=Disabled silences it, bell event still fires for toast
pane_tty=$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
if [ -n "$pane_tty" ]; then
  printf '\a' > "$pane_tty"
else
  client_tty=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
  [ -n "$client_tty" ] && printf '\a' > "$client_tty"
fi
