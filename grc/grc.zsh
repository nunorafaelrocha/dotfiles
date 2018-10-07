# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  alias curl="colourify curl"

  source `brew --prefix`/etc/grc.bashrc
fi
