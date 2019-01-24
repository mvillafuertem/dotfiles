source ~/.bash_villafuerte
source ~/.bash_aliases

if [ -f $(brew --prefix)/bash_completion.d/kubectl ]; then
  . $(brew --prefix)/bash_completion.d/kubectl
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/share/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/share/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/share/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/share/google-cloud-sdk/completion.bash.inc'; fi
