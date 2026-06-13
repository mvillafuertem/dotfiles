#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONF="${SCRIPT_DIR}/config/nftables.conf"

echo "==> Copiando ruleset a /etc/nftables.conf"
/usr/bin/sudo cp "$CONF" /etc/nftables.conf

echo "==> Limpiando tabla anterior (si existe) sin tocar Docker"
/usr/bin/sudo nft flush table inet filter 2>/dev/null || true
/usr/bin/sudo nft delete table inet filter 2>/dev/null || true

echo "==> Cargando reglas nuevas"
/usr/bin/sudo nft -f /etc/nftables.conf

echo "==> Habilitando servicio nftables"
/usr/bin/sudo systemctl enable nftables

echo "==> Reglas activas:"
/usr/bin/sudo nft list ruleset
