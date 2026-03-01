{ user, system, hostname, pkgs, ... }: {
  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.bashInteractive;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit user system; };
    users.${user} = import ./system/${system}/${hostname}.nix;
  };
  nixpkgs.hostPlatform = system;
  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = false;
  nix.enable = false;
  # https://github.com/LnL7/nix-darwin/issues/1041
  services.karabiner-elements.enable = false;
  system.stateVersion = 5;
  system.primaryUser = "${user}";
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
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };
  # https://write.rog.gr/writing/using-touchid-with-tmux/
  # environment = {
  #   etc."pam.d/sudo_local".text = ''
  #     # Managed by Nix Darwin
  #     auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
  #     auth       sufficient     pam_tid.so
  #   '';
  # };
  imports = [ ./modules/darwin ];
}
