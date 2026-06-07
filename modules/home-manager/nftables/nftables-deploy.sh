#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONF="${SCRIPT_DIR}/../config/nftables.conf"

echo "==> Copiando ruleset a /etc/nftables.conf"
sudo cp "$CONF" /etc/nftables.conf

echo "==> Habilitando servicio nftables"
sudo systemctl enable nftables

echo "==> Cargando reglas"
sudo systemctl restart nftables

echo "==> Reglas activas:"
sudo nft list ruleset
