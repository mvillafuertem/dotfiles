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
      $DRY_RUN_CMD sudo cp "${nftablesConf}" /etc/nftables.conf
      $DRY_RUN_CMD sudo systemctl enable nftables
      $DRY_RUN_CMD sudo systemctl restart nftables
    fi
  '';
}
