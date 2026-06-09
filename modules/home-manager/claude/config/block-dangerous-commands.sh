#!/bin/bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

[ -z "$COMMAND" ] && exit 0

block() {
  echo "Blocked: $1" >&2
  exit 2
}

# Mass deletion
echo "$COMMAND" | grep -qE 'rm\s+-[a-z]*r[a-z]*f\s+(~|/\*?$)' \
  && block "mass deletion of root or home (rm -rf ~ / /*)"

# Fork bomb
echo "$COMMAND" | grep -qF ':(){ :|:& };:' \
  && block "fork bomb"

# Pipe remote content to shell
echo "$COMMAND" | grep -qE '(curl|wget)\b.+\|\s*(bash|sh)\b' \
  && block "piping remote content directly to shell (curl|wget | bash)"

# Force push — allow --force-with-lease, block bare --force
if echo "$COMMAND" | grep -qE 'git\s+push\b.+--force' && \
   ! echo "$COMMAND" | grep -q '\-\-force-with-lease'; then
  block "git push --force. Use --force-with-lease or run manually."
fi

# Destructive git reset
echo "$COMMAND" | grep -qE 'git\s+reset\s+--hard\b' \
  && block "git reset --hard can destroy uncommitted work. Run manually if intentional."

# chmod 777
echo "$COMMAND" | grep -qE 'chmod\s+(-[a-z]+\s+)?777\b' \
  && block "chmod 777 is a security risk"

exit 0
