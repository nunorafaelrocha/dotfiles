#!/usr/bin/env bash
rm -rf $HOME/Library/Application\ Support/Code/User
mkdir -p $HOME/Library/Application\ Support/Code
ln -s $DOTFILES/vscode/User $HOME/Library/Application\ Support/Code/User