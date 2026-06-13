# Módulo k3s (home-manager, host NO-NixOS)

Cluster **k3s single-node** en la Raspberry Pi 5 (Raspberry Pi OS + home-manager
standalone). Como NO es NixOS, no existe `services.k3s.enable`: este módulo despliega
un unit systemd de sistema a `/etc/systemd/system` con el patrón `sudo` del módulo
`nftables`, y registra k3s en `raspberrypi.nix`.

`home-manager switch --flake .#raspberrypi` lo deja instalado y arrancado.

---

## ⚠️ Prerequisitos (sin ellos NO funciona)

### 1. cgroup de memoria activado (un reboot, manual)
El kubelet **exige** el controlador de memoria de cgroups. Raspberry Pi OS lo trae
apagado. Añadir a la única línea de `/boot/firmware/cmdline.txt` (separado por espacio,
SIN newline) y reiniciar:

```
cgroup_enable=memory cgroup_memory=1
```

No se automatiza en home-manager (un `cmdline.txt` malformado deja el Pi sin arrancar).
Verificar tras el reboot:
```bash
cat /sys/fs/cgroup/cgroup.controllers   # debe incluir 'memory'
```

### 2. Regla de firewall pod→host (OBLIGATORIA)
El firewall `inet filter` tiene `input policy drop`. Los pods (`10.42.0.0/16`) llegan a
la **API server** (`:6443`) por la interfaz `cni0`. Sin permitir `cni0` en el `input`,
los SYN se descartan y **coredns/metrics-server/local-path-provisioner crashean en bucle**
(el nodo queda `Ready` pero el cluster es inútil).

Ya está en `modules/home-manager/nftables/config/nftables.conf`:
```
iifname { "docker0", "br-*", "cni0", "flannel.1" } accept
```
Si algún día los pods no arrancan, lo primero a mirar:
```bash
sudo journalctl -k --since "-10min" | grep "nft-drop" | grep "SRC=10.42"
```
Si aparecen drops desde `10.42.x` → falta esa regla.

---

## Aplicar de forma segura (SOLO el primer arranque)

El primer `home-manager switch` arranca k3s y reprograma reglas de red. Como el acceso
remoto va por la **VPN sobre un bridge Docker**, hay un riesgo (bajo) de lockout. Para el
**primer** apply conviene una red de seguridad. En switches posteriores NO hace falta:
el módulo solo reinicia k3s si el unit cambió (si no, un `start` idempotente que no toca
la red).

```bash
# 1. Dead-man switch: si k3s rompe la red y te quedas fuera, para k3s solo a los 15 min
#    y recuperas VPN/SSH. (Es un airbag de un solo uso para el arranque.)
sudo bash -c 'nohup sh -c "sleep 900; systemctl stop k3s" >/tmp/k3s-deadman.log 2>&1 & echo $! >/tmp/k3s-deadman.pid'

# 2. Switch dentro de tmux (sobrevive a un corte de SSH/VPN a media activación)
tmux new -s k3s
cd ~/.dotfiles && home-manager switch --flake .#raspberrypi

# 3. Cuando termine OK y verifiques (abajo), desarma el dead-man:
sudo kill $(cat /tmp/k3s-deadman.pid) 2>/dev/null; sudo rm -f /tmp/k3s-deadman.pid
```

> Nota: si el flake está sucio, Nix solo ve ficheros trackeados → `git add` el módulo
> nuevo antes del switch. Valida sin activar con `home-manager build --flake .#raspberrypi`.

---

## Verificar

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml   # ya lo pone home.sessionVariables
kubectl get nodes                              # nodo Ready
kubectl get pods -A                            # coredns + metrics-server + local-path = Running
                                               # traefik y svclb deben estar AUSENTES (--disable)
```
Regresión (que no rompió el homelab): `docker ps` (todo Up), `ss -tlnp | grep -E ':80 |:443 '`
sigue siendo el Traefik de Docker, y la VPN sigue viva.

---

## kubectl

KUBECONFIG apunta a `/etc/rancher/k3s/k3s.yaml` (modo `0640`, grupo `maximusmaria`, NO
world-readable). Tras el switch, abre sesión nueva o `export KUBECONFIG=/etc/rancher/k3s/k3s.yaml`.
`kubectl`/`crictl` vienen del propio paquete k3s (en `~/.nix-profile/bin`).

---

## Rollback / desinstalar

```bash
sudo systemctl disable --now k3s
sudo $(nix eval --raw nixpkgs#k3s_1_35)/bin/k3s-killall.sh   # limpia las reglas iptables/nft de k3s
sudo rm -rf /var/lib/rancher/k3s                            # borra datos del cluster (irreversible)
```
Y quitar `"k3s"` de la lista de módulos en `raspberrypi.nix` + re-switch.
Usar `k3s-killall.sh` (no solo `stop`) para que k3s no deje reglas de red huérfanas.

---

## Decisiones de la fase siguiente (ArgoCD/GitOps — aún NO hechas)

1. **Ingress con el conflicto :80/:443** (el Traefik de Docker los ocupa): o el ingress k8s
   usa puertos alternativos y el Traefik de Docker enruta hacia el cluster, o se migra el edge.
2. **LoadBalancer**: MetalLB (pool L2 en 192.168.0.0/24) vs NodePort vs reactivar klipper
   servicelb en puertos no conflictivos. (Por eso ahora va `--disable servicelb`.)
3. **Bootstrap de ArgoCD**: declarativo (manifest/HelmChart CR en
   `/var/lib/rancher/k3s/server/manifests`) vs out-of-band; y el repo GitOps (recomendado: uno nuevo).

## Multinodo (futuro)
Si añades un 2º nodo, abrir en el `input` del firewall, acotado a la subred de nodos:
`udp dport 8472` (flannel VXLAN) y `tcp dport 10250` (kubelet).
