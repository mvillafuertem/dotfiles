{ pkgs, config, ... }: {
  xdg.configFile = {
    "k9s/aliases.yaml".source = ./config/aliases.yaml;
    "k9s/config.yaml".source = ./config/config.yaml;
    "k9s/skins/catppuccin-mocha.yaml".source = (pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "k9s";
      rev = "82eba6feb442932e28facedfb18dfbe79234f180";
      sha256 = "VLi7G6Rjmbr6feSOg8aLYJmOb+GyJUKi3k9qod6ut9k=";
    } + "/dist/catppuccin-mocha.yaml");
  };

  programs.k9s = { enable = true; };
}
