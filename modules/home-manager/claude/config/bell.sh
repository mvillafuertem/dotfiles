#!/bin/sh
# Client tty only → WezTerm bell event → toast (no pane_tty = no tmux sound)
client_tty=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
[ -n "$client_tty" ] && printf '\a' > "$client_tty"
