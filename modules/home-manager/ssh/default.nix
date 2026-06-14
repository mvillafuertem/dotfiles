{ ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "~/.ssh/config.local" ];
    settings = {
      "*" = {
        # Hosts with LocalForward must override with ControlMaster = no in config.local
        ControlMaster = "auto";
        ControlPath = "~/.ssh/%L-%r@%h:%p";
        ControlPersist = "10m";
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
      };
    };
    # Private hosts live in config.local (not tracked in git).
    # For tunnel-only hosts (LocalForward), add "SessionType none" to suppress
    # the remote shell and MOTD (equivalent to -N flag).
    # To background: ssh -f <host>
    # To kill:       pkill -f "ssh.*<host>"
  };
}
