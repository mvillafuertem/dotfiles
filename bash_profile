source ~/.bash_villafuerte
source ~/.bash_aliases

[[ -r '/usr/local/share/bash-completion/bash_completion' ]] && . '/usr/local/share/bash-completion/bash_completion'
[[ -r '/usr/local/share/bash_completion.d/kubectl' ]] && . '/usr/local/share/bash_completion.d/kubectl' && source <(kubectl completion bash)
[[ -r '/usr/local/share/git-completion.bash' ]] && . '/usr/local/share/git-completion.bash'
[[ -r '/usr/local/share/google-cloud-sdk/completion.bash.inc' ]] && . '/usr/local/share/google-cloud-sdk/completion.bash.inc'
[[ -r '/usr/local/share/google-cloud-sdk/path.bash.inc' ]] && . '/usr/local/share/google-cloud-sdk/path.bash.inc'

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

complete -C '/usr/local/bin/aws_completer' aws
