{ user, system, pkgs, ... }:
{
  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.bashInteractive;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = (import ./home.nix { inherit user pkgs; });
  };
  nixpkgs.hostPlatform = system;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = false;
  # https://github.com/LnL7/nix-darwin/issues/1041
  services.karabiner-elements.enable = true;
  system.stateVersion = 5;
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      minimize-to-application = false;
      expose-group-apps = true;
      tilesize = 36;
      orientation = "bottom";
    };
    # https://github.com/mirkolenz/nixos/blob/main/system/darwin/settings.nix
  };
  security.pam.enableSudoTouchIdAuth = true;
  imports = [ ./modules/darwin ];
}
