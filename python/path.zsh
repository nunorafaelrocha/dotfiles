export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# force uv to use python3.13
UV_PYTHON="$(pyenv which python3.13 2>/dev/null)"
if [ -z "$UV_PYTHON" ] || [ ! -x "$UV_PYTHON" ]; then
  echo "Error: python3.13 not found via pyenv. Please install it with 'pyenv install 3.13.x' and try again." >&2
  return 1 2>/dev/null || exit 1
fi
export UV_PYTHON
