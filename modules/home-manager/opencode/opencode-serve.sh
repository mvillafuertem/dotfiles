#!/usr/bin/env bash
set -e

SESSION="opencode"
PASSWORD=$(cat "$HOME/.config/opencode-server.env" | cut -d= -f2)

tmux kill-session -t "$SESSION" 2>/dev/null || true
tmux new-session -d -s "$SESSION" \
  -e "OPENCODE_SERVER_PASSWORD=$PASSWORD" \
  "opencode serve --hostname 0.0.0.0"

while tmux has-session -t "$SESSION" 2>/dev/null; do
  sleep 5
done
