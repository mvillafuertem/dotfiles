{
  programs.zsh = {
    enable = true; 
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    initExtra = ''
	#[[ -r "$HOME/.dotfiles/bash_profile" ]] && . "$HOME/.dotfiles/bash_profile"
	#[[ -r "$HOME/.dotfiles/bash_villafuerte" ]] && . "$HOME/.dotfiles/bash_villafuerte"
	[[ -r "$HOME/.dotfiles/bash_aliases" ]] && . "$HOME/.dotfiles/bash_aliases"
    '';	
    #shellAliases = {
    #	ll = "ls -l";
    #	update = "sudo nixos-rebuild switch";
    #};
    oh-my-zsh = {
	enable = true;
	plugins = ["zsh-autosuggestions" "zsh-syntax-highlighting"];
    };
  };
}
