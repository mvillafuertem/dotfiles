{ config, pkgs, pkgsUnstable, libs, ... }:
{

  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    fish
    wget
    bat
    bottom
    fzf
    rename
    neofetch # fancy system + hardware info
    tealdeer # fast tldr
    zoxide # habitual `cd`

    # Requires a patched font
    # https://github.com/ryanoasis/nerd-fonts/blob/master/readme.md#patched-fonts
    lsd
    tree
    # better du alternative
    du-dust
    ripgrep
    graphviz
    git-crypt

    httpstat
    curlie


    pkgsUnstable.yt-dlp
    speedtest-cli

    # https://github.com/sindresorhus/fkill
    nodePackages.fkill-cli
    nodePackages.pnpm

    # NOTE `nodejs` is installed on various machines separately, as a specific version is needed for remote VSC
    # TODO figure out how to install a specific version of nodejs only for VSC
    # nodejs # Node 18
    # (yarn.override { nodejs = nodejs-18_x; })


    python38
    jq
    go
    cloc
    docker
    pkgsUnstable.tailscale

    caddy # quick local webserver

    # compression
    zip
    pigz # parallel gzip
    lz4

    # Nix VSC
    nil
    nixpkgs-fmt
    # needed for headless chrome
    # chromium

    git
    # github cli
    gitAndTools.gh

  ];

  programs.dircolors = {
    enable = true;
  };

}