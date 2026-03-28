zmodload zsh/datetime
_zshrc_start=$EPOCHREALTIME

# --- Dotfiles ---
export DOTFILES="$HOME/.dotfiles"

# --- Homebrew ---
if [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
elif [[ -x /usr/local/bin/brew ]]; then
  export HOMEBREW_PREFIX="/usr/local"
fi
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/share/man:${MANPATH:-}"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
fi

# --- PATH ---

# Local bin
[[ :$PATH: == *":$HOME/.local/bin:"* ]] || PATH="$HOME/.local/bin:$PATH"

# Node (n version manager)
export N_PREFIX="$HOME/.n"
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH="$N_PREFIX/bin:$PATH"

# --- Environment ---
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export WORKSPACE=~/workspace
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='zed -w'
fi

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# --- Options ---
setopt NO_BG_NICE NO_HUP NO_LIST_BEEP
setopt LOCAL_OPTIONS LOCAL_TRAPS
setopt HIST_VERIFY SHARE_HISTORY EXTENDED_HISTORY
setopt PROMPT_SUBST CORRECT COMPLETE_IN_WORD IGNORE_EOF
setopt APPEND_HISTORY INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS
setopt complete_aliases

# --- Keybindings ---
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# --- Prompt ---
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr ' %F{yellow}✗%f'
zstyle ':vcs_info:git:*' formats ' %F{blue}git:(%F{red}%b%F{blue})%f%u'
zstyle ':vcs_info:git:*' actionformats ' %F{red}(%b|%a)%f%u'
precmd() { vcs_info }
PROMPT='%(?:%F{green}➜:%F{red}➜)%f  %F{cyan}%B%c%b%f${vcs_info_msg_0_} '

# --- Completion ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' insert-tab pending
autoload -Uz compinit && compinit -C

# --- Aliases ---
alias reload!='. ~/.zshrc'
alias git="nocorrect noglob git"
alias pubkey="cat ~/.ssh/id_ed25519.pub | pbcopy && echo '=> Public key copied to pasteboard.'"
alias afk="open -a ScreenSaverEngine"

alias ll="ls -lAh"
alias la="ls -A"
alias l="ls -CF"
alias search="rg -i"

# IP
alias ip4="dig +short myip.opendns.com A @resolver1.opendns.com"
alias ip6="dig +short -6 myip.opendns.com AAAA @resolver1.ipv6-sandbox.opendns.com"
alias iplocal="ipconfig getifaddr en0"

# DNS
alias dns-check="networksetup -getdnsservers Wi-Fi"
alias dns-clear="networksetup -setdnsservers Wi-Fi empty"
alias dns-flush="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"
alias dns-set-cloudflare="networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001"
alias dns-set-google="networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844"

# --- Functions ---

# Docker cleanup
dkr() {
  case "$1" in
    "kill")  docker ps -q | xargs -r docker kill ;;
    "rmc")   docker ps -a -q | xargs -r docker rm ;;
    "rmi")   docker images -q | xargs -r docker rmi ;;
    "reset") dkr kill; docker network prune -f; dkr rmc; dkr rmi ;;
    *)       echo "Usage: dkr [kill|rmc|rmi|reset]" ;;
  esac
}

# --- Python (pyenv, lazy) ---
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

# --- GRC colorizer ---
[[ -f "$HOMEBREW_PREFIX/etc/grc.zsh" ]] && source "$HOMEBREW_PREFIX/etc/grc.zsh"

# --- Local overrides ---
[[ -f ~/.localrc ]] && source ~/.localrc
[[ -f ~/.local/bin/env ]] && source ~/.local/bin/env

if [[ -o interactive ]]; then
  printf "zshrc loaded in %.0fms\n" $(( (EPOCHREALTIME - _zshrc_start) * 1000 ))
fi
unset _zshrc_start
