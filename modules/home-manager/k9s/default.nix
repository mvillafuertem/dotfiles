{ config, ... }: {
  xdg.configFile.k9s = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
  programs.k9s = { enable = true; };
}
