#!/usr/bin/env bash

if test $(which apm); then
  $DOTFILES/bin/atom-package-install
fi
