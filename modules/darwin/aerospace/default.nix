{ pkgs, ... }: {
  services.aerospace = {
    enable = false;
    settings = pkgs.lib.importTOML ./config/aerospace.toml;
  };
}
