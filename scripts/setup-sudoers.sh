SUDOERS_FILE="/etc/sudoers.d/10-dotfiles-nopasswd"
SUDOERS_CONTENT="$USER ALL=(ALL) NOPASSWD: /nix/var/nix/profiles/default/bin/home-manager"
if [ ! -f "$SUDOERS_FILE" ] || ! grep -qF "$SUDOERS_CONTENT" "$SUDOERS_FILE"; then
  echo "$SUDOERS_CONTENT" | sudo tee "$SUDOERS_FILE" > /dev/null
  sudo chmod 440 "$SUDOERS_FILE"
fi
