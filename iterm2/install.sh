#!/usr/bin/env bash

# iTerm is only installed on macOS
if [ `uname` == "Darwin" ]; then
  # Install the custom themes for iTerm.
  open $DOTFILES/"iterm2/themes/material-design-colors.itermcolors"
  open $DOTFILES/"iterm2/themes/nuno-blue.itermcolors"
  open $DOTFILES/"iterm2/themes/nuno.itermcolors"
fi
