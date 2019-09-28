source ~/.bash_villafuerte
source ~/.bash_aliases

if [ -f /usr/local/share/bash_completion.d/kubectl ]; then
  . /usr/local/share/bash_completion.d/kubectl
  source <(kubectl completion bash)
fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/share/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/share/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/share/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/share/google-cloud-sdk/completion.bash.inc'; fi


