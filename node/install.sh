#!/usr/bin/env bash

# install n
if test ! $(which n); then
  curl -L https://git.io/n-install | N_PREFIX="$HOME/.n" bash -s -- -y

  exec $SHELL
fi

if test ! $(which node -v); then
  echo "Installing node latest..."

  n latest
fi
