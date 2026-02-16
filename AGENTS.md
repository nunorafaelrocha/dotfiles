# Dotfiles

Simple dotfiles for macOS on Apple Silicon. Managed by `make`.

## Target platform

- **macOS only** — no Linux/Windows support needed. Bash-isms, macOS-specific tools (`defaults`, `scutil`, `pbcopy`, `hdiutil`), and Homebrew paths are all intentional.
- **Apple Silicon only** — Homebrew is assumed at `/opt/homebrew`. Intel Mac compatibility is not a goal.

## Structure

Flat layout — config files at the root or in small topic directories, symlinked to `~/` via `make link`.

## Key files

- `Makefile` — Installer. Run `make` for full install, or individual targets (`make link`, `make brew`, etc.)
- `zshrc` — All shell config in one file (PATH, env, options, prompt, aliases, functions)
- `Brewfile` — All Homebrew packages and casks
- `git/gitconfig` — Git configuration (includes `git/gitconfig.local` for identity)
- `vim/vimrc` — Vim configuration
- `macos/defaults.sh` — macOS system preferences

## Symlinks

`make link` creates these:
- `zshrc` → `~/.zshrc`
- `git/gitconfig` → `~/.gitconfig`
- `git/gitignore` → `~/.gitignore`
- `git/gitmessage` → `~/.gitmessage`
- `vim/vimrc` → `~/.vimrc`
- `vim/vimrc.bundles` → `~/.vimrc.bundles`
- `macos/hushlogin` → `~/.hushlogin`

## Rules

- Keep secrets out of the repo. Use `~/.localrc` for private env vars.
- `git/gitconfig.local` is gitignored and holds user-specific git identity. Create via `make gitsetup`.
- When adding or removing a setting from `macos/defaults.sh`, always update `macos/audit.sh` to match.
