{ ... }: {

  xdg.configFile.wezterm = {
    source = ./config;
    recursive = true;
  };

  programs.wezterm.enable = true;

}
