# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Init fasd and cache init code
fasd_cache="$HOME/.fasd-init-bash"

if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook >| "$fasd_cache"
fi

source "$fasd_cache"
unset fasd_cache
