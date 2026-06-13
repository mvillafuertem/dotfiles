{ config, lib, pkgs, ... }:

# k3s single-node server, managed declaratively from standalone home-manager
# on Raspberry Pi OS (Debian, NOT NixOS). The systemd SYSTEM unit is deployed
# to /etc/systemd/system via the same passwordless-sudo activation idiom used
# by the nftables module. Hardened per a 4-lens adversarial review (2026-06-13).
#
# Prerequisite (already done): memory cgroup enabled in /boot/firmware/cmdline.txt.
#
# Rollback: `sudo systemctl disable --now k3s` then, to flush k3s's own
# iptables/nft rules cleanly, run the killall script shipped in the package:
#   sudo $(nix eval --raw nixpkgs#k3s_1_35)/bin/k3s-killall.sh
# and optionally `sudo rm -rf /var/lib/rancher/k3s`.

let
  k3sPkg = pkgs.k3s_1_35; # pinned; == pkgs.k3s (1.35.5+k3s1) on the current nixpkgs pin

  # Kernel modules k3s/kubelet need (on NixOS these come from boot.kernelModules).
  k3sModulesConf = pkgs.writeText "k3s-modules.conf" ''
    overlay
    br_netfilter
  '';

  # Sysctls (on NixOS these come from boot.kernel.sysctl). On this host they are
  # already set (Docker loads br_netfilter and sets these), so this is just
  # reboot-persistence — NOT the thing that makes coexistence safe.
  k3sSysctlConf = pkgs.writeText "k3s-sysctl.conf" ''
    net.bridge.bridge-nf-call-iptables = 1
    net.bridge.bridge-nf-call-ip6tables = 1
    net.ipv4.ip_forward = 1
  '';

  # systemd unit modeled on upstream k3s.service + the NixOS rancher module.
  # PATH intentionally unset: the nixpkgs k3s binary is wrapProgram'd with its
  # runtime deps (iptables, ip, mount, nsenter, conntrack, runc, containerd, CNI).
  k3sUnit = pkgs.writeText "k3s.service" ''
    [Unit]
    Description=Lightweight Kubernetes (k3s server, managed by home-manager)
    Documentation=https://k3s.io
    After=network-online.target
    Wants=network-online.target

    [Service]
    Type=notify
    # Optional out-of-band env (proxy/NO_PROXY, K3S_*); '-' = fine if absent.
    EnvironmentFile=-/etc/systemd/system/k3s.service.env
    KillMode=process
    Delegate=yes
    Restart=always
    RestartSec=5s
    # Finite (not 0): a stuck first start fails loudly instead of hanging the
    # synchronous `systemctl restart` run inside home-manager activation.
    TimeoutStartSec=300
    LimitNOFILE=1048576
    LimitNPROC=infinity
    LimitCORE=infinity
    TasksMax=infinity
    # Host modprobe (parity with upstream); '-' = best-effort, modules are also
    # loaded at boot via /etc/modules-load.d/k3s.conf.
    ExecStartPre=-/sbin/modprobe overlay
    ExecStartPre=-/sbin/modprobe br_netfilter
    ExecStart=${k3sPkg}/bin/k3s server --disable traefik --disable servicelb --node-ip 192.168.0.30 --flannel-iface wlan0 --write-kubeconfig-mode 0640 --write-kubeconfig-group maximusmaria --kubelet-arg=fail-swap-on=false

    [Install]
    WantedBy=multi-user.target
  '';
in
{
  home.packages = [ k3sPkg ];

  # kubeconfig is group-readable (0640, group maximusmaria) — NOT world-readable,
  # because this host runs ~20 other containers. The user is in group maximusmaria.
  home.sessionVariables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";

  # Deploy mirroring nftables/default.nix. Key hardening vs the naive version:
  # restart ONLY when the unit content changed; otherwise just ensure it is
  # enabled and running (idempotent `start`, no churn). This prevents an
  # unrelated `home-manager switch` from tearing down the control plane and
  # reprogramming flannel/kube-proxy rules while the VPN (Docker-bridge based)
  # is the operator's only remote access.
  home.activation.deployK3s = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD /usr/bin/sudo cp ${k3sModulesConf} /etc/modules-load.d/k3s.conf
    $DRY_RUN_CMD /usr/bin/sudo cp ${k3sSysctlConf} /etc/sysctl.d/90-k3s.conf

    if ! /usr/bin/sudo cmp -s ${k3sUnit} /etc/systemd/system/k3s.service 2>/dev/null; then
      $DRY_RUN_CMD /usr/bin/sudo cp ${k3sUnit} /etc/systemd/system/k3s.service
      $DRY_RUN_CMD /usr/bin/sudo systemctl daemon-reload
      $DRY_RUN_CMD /usr/bin/sudo systemctl enable k3s.service
      $DRY_RUN_CMD /usr/bin/sudo systemctl restart k3s.service
    else
      $DRY_RUN_CMD /usr/bin/sudo systemctl enable k3s.service
      $DRY_RUN_CMD /usr/bin/sudo systemctl start k3s.service
    fi
  '';
}
