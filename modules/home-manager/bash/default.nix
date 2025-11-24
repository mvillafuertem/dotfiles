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
      [[ -r "${pkgs.git}/share/git/contrib/completion/git-completion.bash" ]] && . "${pkgs.git}/share/git/contrib/completion/git-completion.bash"
      #[[ -r "${config.xdg.configHome}/bash/bash_profile" ]] && . "${config.xdg.configHome}/bash/bash_profile"
      #[[ -r "${config.xdg.configHome}/bash/bash_villafuerte" ]] && . "${config.xdg.configHome}/bash/bash_villafuerte"
      [[ -r "${config.xdg.configHome}/bash/bash_aliases" ]] && . "${config.xdg.configHome}/bash/bash_aliases"
      
      # https://github.com/catppuccin/skim
      export SKIM_DEFAULT_OPTIONS="$SKIM_DEFAULT_OPTIONS \
--color=fg:#cdd6f4,bg:#1e1e2e,matched:#313244,matched_bg:#f2cdcd,current:#cdd6f4,current_bg:#45475a,current_match:#1e1e2e,current_match_bg:#f5e0dc,spinner:#a6e3a1,info:#cba6f7,prompt:#89b4fa,cursor:#f38ba8,selected:#eba0ac,header:#94e2d5,border:#6c7086"
    '';
  };
}
