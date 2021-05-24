# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] ))
then
  if [[ `uname` == "Darwin" && (( $+commands[brew] )) ]]
  then
    source `brew --prefix`/etc/grc.zsh
  else
    [[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
  fi
fi
