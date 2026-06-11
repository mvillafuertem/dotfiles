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
    # Private hosts live in config.local (not tracked in git).
    # For tunnel-only hosts (LocalForward), add "SessionType none" to suppress
    # the remote shell and MOTD (equivalent to -N flag).
    # To background: ssh -f <host>
    # To kill:       pkill -f "ssh.*<host>"
  };
}
