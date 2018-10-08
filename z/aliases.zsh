if ((!$+commands[fasd])); then
  return 1
fi

alias z='fasd_cd -d'
