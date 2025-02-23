{ pkgs, config, ... }: {
  xdg.configFile = {
    "k9s/aliases.yaml".source = ./config/aliases.yaml;
    "k9s/config.yaml".source = ./config/config.yaml;
    "k9s/skins/catppuccin-mocha.yaml".source = (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "k9s";
      rev = "fdbec82284744a1fc2eb3e2d24cb92ef87ffb8b4";
      sha256 = "VLi7G6Rjmbr6feSOg8aLYJmOb+GyJUKi3k9qod6ut9k=";
    } + "/dist/catppuccin-mocha.yaml");
  };

  programs.k9s = { enable = true; };
}
