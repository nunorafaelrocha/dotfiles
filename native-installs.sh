#!/usr/bin/env bash

# Native installers for tools not managed by Homebrew.
# Each block checks if the tool exists before installing.

# Claude Code
if ! command -v claude >/dev/null 2>&1; then
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "Updating Claude Code..."
  claude update
fi

# Ollama
if ! command -v ollama >/dev/null 2>&1; then
  echo "Installing Ollama..."
  curl -fsSL https://ollama.com/install.sh | sh
else
  echo "Ollama already installed, skipping."
fi

# Zed CLI
if ! command -v zed >/dev/null 2>&1; then
  if [ -d "/Applications/Zed.app" ]; then
    echo "Installing Zed CLI..."
    mkdir -p "$HOME/.local/bin"
    ln -sf /Applications/Zed.app/Contents/MacOS/cli "$HOME/.local/bin/zed"
  else
    echo "Zed.app not found, skipping CLI install."
  fi
else
  echo "Zed CLI already installed, skipping."
fi
