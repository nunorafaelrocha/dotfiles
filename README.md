<div align="center">
  <img src="logo.jpg" alt="Dotfiles" height="300px">
</div>

# 🚀 Nuno's Dotfiles

Your dotfiles are how you personalize your system. These are mine. 😎

## Prerequisites

- macOS with Xcode Command Line Tools (`xcode-select --install`)

## Install

```sh
git clone https://github.com/nunorafaelrocha/dotfiles ~/.dotfiles
cd ~/.dotfiles
make
```

## Usage

```sh
make help      # Show all targets
make link      # Create symlinks
make brew      # Install Homebrew packages
make node      # Install Node.js via n
make python    # Install Python via pyenv
make vim       # Install vim plugins
make macos     # Apply macOS defaults
make gitsetup  # Configure git identity
make clean     # Remove symlinks
```

## Structure

```
Makefile              # The installer
Brewfile              # Homebrew packages
zshrc                 # All shell config (PATH, env, prompt, aliases, functions)
git/                  # Git configuration
vim/                  # Vim configuration
macos/                # macOS defaults and hushlogin
```

## Customization

- Edit `zshrc` for shell config (aliases, PATH, functions, etc.)
- Edit `Brewfile` for packages
- Use `~/.localrc` for private env vars and secrets
- Run `make gitsetup` to configure git identity (stored in `git/gitconfig.local`, which is gitignored)
