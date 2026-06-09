#!/bin/sh
# Pane pty → tmux shows 󰂚 bell indicator on tab
pane_tty=$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
[ -n "$pane_tty" ] && printf '\a' > "$pane_tty"

# Client tty → OSC 1337 user-var (silent) triggers WezTerm toast_notification
client_tty=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
[ -n "$client_tty" ] && printf '\033]1337;SetUserVar=CLAUDE_DONE=1\007' > "$client_tty"
