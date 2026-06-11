{ ... }: {
  programs.ssh = {
    enable = true;
    # Hosts with LocalForward must override with ControlMaster = no in config.local
    controlMaster = "auto";
    controlPath = "~/.ssh/%L-%r@%h:%p";
    controlPersist = "10m";
    serverAliveInterval = 60;
    serverAliveCountMax = 3;
    includes = [ "~/.ssh/config.local" ];
  };
}
