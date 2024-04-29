{ pkgs, ... }: {
  xdg.configFile.tmux = {
    source = ./config;
    recursive = true;
  };

  #home.file.".tmux.conf" = { source = ./config/tmux.conf; };
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ 
      # tmuxPlugins.catppuccin
    ];
  };
}
