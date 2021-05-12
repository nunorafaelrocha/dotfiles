#!/usr/bin/env bash

# Installing software (not using brew casks because it's only supported for macOS atm).

if [ `uname` == "Linux" ]; then
  # add package repositories
  wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'

  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'


  # update system
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get autoremove -y
  sudo apt-get autoclean -y

  # basic
  sudo apt-get install -y \
    apt-transport-https \
    apt-utils \
    build-essential \
    curl \
    git \
    locales \
    wget

  # tools
  sudo apt-get install -y \
    ack \
    awscli \
    coreutils \
    exa \
    fasd \
    git-extras \
    httpie \
    imagemagick \
    jp2a \
    jq \
    openssl \
    unrar \
    vim \
    zsh

  # yarn
  sudo apt-get install -y --no-install-recommends yarn

  # locale
  sudo locale-gen "en_US.UTF-8"
  sudo dpkg-reconfigure --frontend noninteractive locales

  # Brew specific installers
  brew bundle --file $DOTFILES/homebrew/Brewfile.linux

  # install apps - not using brew cask because installing casks is supported only on macOS
  sudo apt-get install -y \
    atom \
    code
fi
