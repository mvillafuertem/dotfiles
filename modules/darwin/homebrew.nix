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
    brews = [
      "tree-sitter"
      "tree-sitter-cli"
    ];
    casks = [
      {
        name = "blackhole-16ch";
        greedy = true;
      }
      # "brave-browser"
      {
        name = "claude";
        greedy = true;
      }
      # {
      #   name = "jdownloader";
      #   greedy = true;
      # }
      {
        name = "jetbrains-toolbox";
        greedy = true;
      }
      {
        name = "obsidian";
        greedy = true;
      }
      {
        name = "spotify";
        greedy = true;
      }
      # "docker"
      {
        name = "google-chrome";
        greedy = true;
      }
      {
        name = "postman";
        greedy = true;
      }
      {
        name = "wezterm";
        greedy = true;
      }
      {
        name = "vnc-viewer";
        greedy = true;
      }
    ];
  };

}
