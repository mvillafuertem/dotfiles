{ pkgs, lib, ... }:
let
  nftablesConf = ./config/nftables.conf;
in {
  home.file.".local/bin/nftables-deploy" = {
    source = ./nftables-deploy.sh;
    executable = true;
  };

  home.activation.deployNftables = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -f "${nftablesConf}" ]; then
      $DRY_RUN_CMD /usr/bin/sudo cp "${nftablesConf}" /etc/nftables.conf
      $DRY_RUN_CMD /usr/bin/sudo nft flush table inet filter 2>/dev/null || true
      $DRY_RUN_CMD /usr/bin/sudo nft delete table inet filter 2>/dev/null || true
      $DRY_RUN_CMD /usr/bin/sudo nft -f /etc/nftables.conf
      $DRY_RUN_CMD /usr/bin/sudo systemctl enable nftables
    fi
  '';
}
