#!/usr/bin/env bash

if [ `uname` == "Darwin" ]; then
  rm -rf $HOME/Library/Application\ Support/Code/User
  ln -s $DOTFILES/vscode/User $HOME/Library/Application\ Support/Code/User
fi

if [ `uname` == "Linux" ]; then
  if [ -d "$HOME/.config/Code" ]; then
    rm -rf $HOME/.config/Code/User
    ln -s $DOTFILES/vscode/User $HOME/.config/Code/User
  fi
fi
