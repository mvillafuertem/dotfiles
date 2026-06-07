{ ... }: {
  home.file.".local/bin/opencode-serve.sh" = {
    source = ./opencode-serve.sh;
    executable = true;
  };
  home.file.".config/systemd/user/opencode-serve.service".source = ./opencode-serve.service;
  home.file.".config/opencode/tui.json".source = ./tui.json;
}
