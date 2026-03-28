#!/usr/bin/env bash

# Native installers for tools not managed by Homebrew.
# Each block checks if the tool exists before installing.

# Claude Code
if ! command -v claude >/dev/null 2>&1; then
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "Claude Code already installed, skipping."
fi
