#!/bin/sh
msg="${1:-Notification}"
client_tty=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
[ -n "$client_tty" ] && printf '\033]9;%s\007' "$msg" > "$client_tty"
pane_tty=$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
if [ -n "$pane_tty" ]; then
  printf '\a' > "$pane_tty"
elif [ -n "$client_tty" ]; then
  printf '\a' > "$client_tty"
fi
