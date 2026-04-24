{ ... }:
{
  homebrew = {
    enable = true;
    enableBashIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    global.autoUpdate = true;
    caskArgs.no_quarantine = true;
    brews = [ ];
    casks = [
      {
        name = "blackhole-16ch";
        greedy = true;
      }
      # "brave-browser"
      {
        name = "jdownloader";
        greedy = true;
      }
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
