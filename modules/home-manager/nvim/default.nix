{ pkgs, ... }: {
  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    #extraConfig = builtins.readFile "${config.home.homeDirectory}/.dotfiles/vimrc";
    # package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [ ];
    # extraConfig = lib.fileContents ../path/to/your/init.vim;
    #plugins = let
    #nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins:
    #  with treesitter-plugins; [
    #    bash
    #    lua
    #    nix
    #    python
    #    rust
    #    scala
    #  ]);
    # in
    # with pkgs.vimPlugins; [
    #  packer-nvim # nix search 'nixpkgs#vimPlugins' packer
    #  nvim-treesitter-with-plugins
    #];
  };
}
