{ ... }:
{
  homebrew = {
    enable = true;
    enableBashIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    global.autoUpdate = true;

    # Paquetes comunes a TODOS los hosts darwin.
    # Para paquetes específicos por host, ver: modules/darwin/hosts/<hostname>.nix
    brews = [
      "tree-sitter"
      "tree-sitter-cli"
    ];
    casks = [
      { name = "wezterm"; greedy = true; }
      { name = "google-chrome"; greedy = true; }
    ];
  };
}
