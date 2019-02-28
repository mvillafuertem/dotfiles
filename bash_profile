source ~/.bash_villafuerte
source ~/.bash_aliases
PATH=$PATH:/usr/local/
if [ -f $(brew --prefix)/bash_completion.d/kubectl ]; then
  . $(brew --prefix)/bash_completion.d/kubectl
fi

source /dev/stdin <<<"$(kubectl completion bash)"

source <(kubectl completion bash)

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/share/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/share/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/share/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/share/google-cloud-sdk/completion.bash.inc'; fi


