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
    enableCompletion = true;
    bashrcExtra = ''
      export BASH_SILENCE_DEPRECATION_WARNING=1
      #[[ -r "${config.xdg.configHome}/bash/bash_profile" ]] && . "${config.xdg.configHome}/bash/bash_profile"
      #[[ -r "${config.xdg.configHome}/bash/bash_villafuerte" ]] && . "${config.xdg.configHome}/bash/bash_villafuerte"
      [[ -r "${config.xdg.configHome}/bash/bash_aliases" ]] && . "${config.xdg.configHome}/bash/bash_aliases"
    '';
  };
}
