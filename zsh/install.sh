#!/usr/bin/env bash

which zsh | sudo tee -a /etc/shells

if [[ -z "${USER}" ]]; then
  sudo chsh -s "$(which zsh)"
else
  sudo chsh -s "$(which zsh)" "${USER}"
fi
