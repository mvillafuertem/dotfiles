#!/bin/sh
# Pane pty → tmux shows bell indicator on tab
pane_tty=$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
[ -n "$pane_tty" ] && printf '\a' > "$pane_tty"

# Client tty → WezTerm receives bell and fires toast_notification
client_tty=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
[ -n "$client_tty" ] && printf '\a' > "$client_tty"
