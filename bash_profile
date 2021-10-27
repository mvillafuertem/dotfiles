source ~/.bash_villafuerte
source ~/.bash_aliases

export JAVA_HOME=$(/usr/libexec/java_home -v 11)

export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[[ -r '/usr/local/share/bash-completion/bash_completion' ]] && . '/usr/local/share/bash-completion/bash_completion'
[[ -r '/usr/local/share/bash_completion.d/kubectl' ]] && . '/usr/local/share/bash_completion.d/kubectl' && source <(kubectl completion bash)
[[ -r '/usr/local/share/git-completion.bash' ]] && . '/usr/local/share/git-completion.bash'
[[ -r '/usr/local/share/google-cloud-sdk/completion.bash.inc' ]] && . '/usr/local/share/google-cloud-sdk/completion.bash.inc'
[[ -r '/usr/local/share/google-cloud-sdk/path.bash.inc' ]] && . '/usr/local/share/google-cloud-sdk/path.bash.inc'

# if which pyenv > /dev/null; then eval "$(pyenv init --path)"; fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
# export PYENV_ROOT=/usr/local/var/pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export BASE_PROMPT=$PS1
function updatePyEnvPrompt {
  [[ -f /usr/local/bin/pyenv ]] \
  && [[ "$(pyenv version-name)" != "system" ]] \
  && export PS1='\[\033[3;38;5;172m\] $(pyenv version-name) \[\033[0m\]'$BASE_PROMPT  ||  export PS1=$BASE_PROMPT
}
export PROMPT_COMMAND='updatePyEnvPrompt'
export PATH="$PYENV_ROOT/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

complete -C '/usr/local/bin/aws_completer' aws


export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

