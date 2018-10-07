if ((!$+commands[npm])); then
  return 1
fi

# Adds node_modules/.bin to the PATH
npm-bin-hook() {
  if [[ -a package.json ]]; then
    path=(
      $PWD/node_modules/.bin
      $path
    )
  else
    PATH=$(echo -n $PATH | tr ":" "\n" | sed "/node_modules/d" | tr "\n" ":")
  fi
}

autoload -Uz add-zsh-hook

add-zsh-hook preexec npm-bin-hook
