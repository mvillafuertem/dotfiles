source ~/.bash_villafuerte
source ~/.bash_aliases

[[ -r '/usr/local/share/bash-completion/bash_completion' ]] && . '/usr/local/share/bash-completion/bash_completion'
[[ -r '/usr/local/share/bash_completion.d/kubectl' ]] && . '/usr/local/share/bash_completion.d/kubectl' && source <(kubectl completion bash)
[[ -r '/usr/local/share/git-completion.bash' ]] && . '/usr/local/share/git-completion.bash'
[[ -r '/usr/local/share/google-cloud-sdk/completion.bash.inc' ]] && . '/usr/local/share/google-cloud-sdk/completion.bash.inc'
[[ -r '/usr/local/share/google-cloud-sdk/path.bash.inc' ]] && . '/usr/local/share/google-cloud-sdk/path.bash.inc'
