if ! command -v pyenv >/dev/null 2>&1; then
  echo "Error: pyenv is not installed. Please install pyenv first." >&2
  exit 1
fi

pyenv install 3.13
pyenv global 3.13

# python package and project manager
curl -LsSf https://astral.sh/uv/install.sh | sh
