{ inputs, config, pkgs, lib, darwin, ... }: {
  nixpkgs.hostPlatform = "aarch64-darwin";
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = false;
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      minimize-to-application = false;
      expose-group-by-app = true;
      tilesize = 36;
      orientation = "left";
    };
  };
  security.pam.enableSudoTouchIdAuth = true;
}
