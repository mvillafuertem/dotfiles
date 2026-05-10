{ pkgs, ... }: {
  xdg.configFile.tmux = {
    source = ./config;
    recursive = true;
  };

  #home.file.".tmux.conf" = { source = ./config/tmux.conf; };
  programs.tmux = {
    enable = true;
    # Use the latest bash from nixpkgs (works on NixOS and nix-darwin,
    # independent of the username). Resolves to a /nix/store path.
    shell = "${pkgs.bashInteractive}/bin/bash";
    plugins = with pkgs; [ 
      # tmuxPlugins.catppuccin
    ];
  };
}
