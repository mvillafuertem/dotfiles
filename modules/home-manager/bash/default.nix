{ config, pkgs, ... }: {
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
    shellOptions = [ ];
    enableCompletion = true;
    bashrcExtra = ''
      export BASH_SILENCE_DEPRECATION_WARNING=1
      [[ -r "${pkgs.git}/share/git/contrib/completion/git-completion.bash" ]] && . "${pkgs.git}/share/git/contrib/completion/git-completion.bash"
      #[[ -r "${config.xdg.configHome}/bash/bash_profile" ]] && . "${config.xdg.configHome}/bash/bash_profile"
      #[[ -r "${config.xdg.configHome}/bash/bash_villafuerte" ]] && . "${config.xdg.configHome}/bash/bash_villafuerte"
      [[ -r "${config.xdg.configHome}/bash/bash_aliases" ]] && . "${config.xdg.configHome}/bash/bash_aliases"
      
      ### ─── SAFE SHARED HISTORY FOR BASH ───────────────────────────────
      # Set the maximum number of commands to keep in memory
      export HISTSIZE=100000

      # Set the maximum number of commands to save in the history file
      export HISTFILESIZE=200000

      # Control how history is saved:
      # - ignoredups → ignore duplicate lines that are immediately consecutive
      # - ignorespace → commands starting with a space are not saved
      export HISTCONTROL=ignoredups:ignorespace

      # Specify commands to ignore entirely in history:
      # &       → the previous command repeated via !!
      # [ ]*    → lines containing only spaces
      # exit    → closing the shell
      # bg, fg  → job control commands
      # history → viewing history itself
      export HISTIGNORE="&:[ ]*:exit:bg:fg:history"

      # Ensure new history lines are appended to the history file, not overwritten
      shopt -s histappend

      # Live synchronisation of history across multiple shells:
      # - history -a → append only the new lines from this session to the history file
      # - history -n → read only new lines from the history file into this session
      # This keeps all shells in sync in real time without clearing history
      PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

      # https://github.com/catppuccin/skim
      export SKIM_DEFAULT_OPTIONS="$SKIM_DEFAULT_OPTIONS \
      --color=fg:#cdd6f4,bg:#1e1e2e,matched:#313244,matched_bg:#f2cdcd,current:#cdd6f4,current_bg:#45475a,current_match:#1e1e2e,current_match_bg:#f5e0dc,spinner:#a6e3a1,info:#cba6f7,prompt:#89b4fa,cursor:#f38ba8,selected:#eba0ac,header:#94e2d5,border:#6c7086"

      # Disable WezTerm shell integration only when inside Neovim to prevent OSC 1337 sequences
      # from appearing as text in the :terminal inside tmux
      # https://github.com/wez/wezterm/issues/3794
      if [ -n "$NVIM" ]; then
        export WEZTERM_SHELL_SKIP_ALL=1
      fi

    '';
  };
}
