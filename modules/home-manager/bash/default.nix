{config, pkgs, ...}: {
  home.file.".inputrc" = { source = ./config/inputrc; };
  xdg.configFile.bash = {
    source = ./config;
    recursive = true;
  };
  # https://github.com/nix-community/home-manager/pull/3238
  # programs.blesh.enable = true;
  # https://github.com/nix-community/home-manager/blob/master/modules/modules.nix
  programs.ripgrep.enable = true;
  programs.bash = {
    enable = true;
    shellOptions = [];
    enableCompletion = false;
    bashrcExtra = ''

export BASH_SILENCE_DEPRECATION_WARNING=1

source <(kubectl completion bash)

complete -C "${pkgs.awscli2}/bin/aws_completer" aws

[[ -z BASH_COMPLETION_VERSINFO ]] && . "${pkgs.bash-completion}/etc/profile.d/bash_completion.sh"
[[ -r "${pkgs.git}/share/git/contrib/completion/git-completion.bash" ]] && . "${pkgs.git}/share/git/contrib/completion/git-completion.bash"
[[ -r "${pkgs.bash-completion}/share/bash-completion/completions/kubectl" ]] || kubectl completion bash > "${pkgs.bash-completion}/share/bash-completion/completions/kubectl"

#[[ -r "${config.xdg.configHome}/bash/bash_profile" ]] && . "${config.xdg.configHome}/bash/bash_profile"
#[[ -r "${config.xdg.configHome}/bash/bash_villafuerte" ]] && . "${config.xdg.configHome}/bash/bash_villafuerte"
[[ -r "${config.xdg.configHome}/bash/bash_aliases" ]] && . "${config.xdg.configHome}/bash/bash_aliases"
    '';
  };
}
