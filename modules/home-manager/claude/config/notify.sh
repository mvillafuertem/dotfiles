#!/bin/sh
msg="${1:-Notification}"
client_tty=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
[ -n "$client_tty" ] && printf '\033]9;%s\007' "$msg" > "$client_tty"
