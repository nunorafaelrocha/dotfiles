#!/usr/bin/env bash

# Making sure N_PREFIX is set.
source $DOTFILES/node/path.zsh

if test ! $(which node -v); then
  echo "Installing node latest..."

  n latest
fi
