#!/usr/bin/env bash
# Auto-refresh AWS SSO for the EKS exec credential plugin.
#
# El kubeconfig apunta el `exec.command` de cada contexto de fabric a este script
# y mantiene su propio AWS_PROFILE en `exec.env` (no se hardcodea ningún perfil
# ni account id aquí; es genérico). Flujo:
#   1) intenta `aws <args>` (= aws eks get-token). Si la sesión SSO es válida,
#      emite el JSON de credenciales por STDOUT y termina.
#   2) si falla por sesión SSO caducada/inválida, corre `aws sso login` (salida a
#      STDERR para no corromper el JSON que kubectl/k9s leen por STDOUT) y reintenta.
#   3) cualquier otro error (red, cluster, permisos) se propaga tal cual.
#
# NOTA: ~/.kube/config NO se versiona (gitignored, contiene account ids y lo
# reescribe kubectl). Solo se versiona este wrapper, que kubeconfig referencia
# por ruta absoluta en el `exec.command` de los contextos que lo necesiten.
set -uo pipefail

err=$(mktemp)
trap 'rm -f "$err"' EXIT

# Intento 1 — camino feliz.
if out=$(aws "$@" 2>"$err"); then
  printf '%s' "$out"
  exit 0
fi

# ¿El fallo es por SSO caducado/inválido? Solo entonces logueamos.
if grep -qiE 'sso session|run +aws +sso +login|token .*(expired|invalid)' "$err"; then
  aws sso login >&2          # usa AWS_PROFILE inyectado por el exec.env
  exec aws "$@"              # reintento: JSON -> STDOUT
fi

# Otro error: propágalo y falla.
cat "$err" >&2
exit 1
