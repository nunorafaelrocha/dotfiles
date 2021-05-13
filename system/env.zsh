export LANG="en_GB"
export LANGUAGE="en_GB:en"
export LC_ALL="en_GB.UTF-8"
export LC_CTYPE="UTF-8"
export WORKSPACE=~/workspace

# Preferred editor for remote and local sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='atom'
fi
