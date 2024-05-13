{ inputs, config, pkgs, lib, darwin, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = false;
  services.karabiner-elements.enable = true;
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      minimize-to-application = false;
      expose-group-by-app = true;
      tilesize = 36;
      orientation = "left";
    };
    # https://github.com/mirkolenz/nixos/blob/main/system/darwin/settings.nix
    trackpad = {
      #ActuationStrength = 1;
      #Clicking = true;
      #Dragging = true;
      #FirstClickThreshold = 1;
      #SecondClickThreshold = 2;
      #TrackpadRightClick = true;
      # TrackpadThreeFingerDrag = true;
    };
  };
  security.pam.enableSudoTouchIdAuth = true;
}
