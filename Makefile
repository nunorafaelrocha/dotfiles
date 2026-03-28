SHELL := /bin/bash
DOTFILES := $(shell pwd)
HOMEBREW_PREFIX := $(or $(shell /opt/homebrew/bin/brew --prefix 2>/dev/null),$(shell /usr/local/bin/brew --prefix 2>/dev/null),$(if $(filter arm%,$(shell uname -m)),/opt/homebrew,/usr/local))

# Require Xcode Command Line Tools
ifeq ($(shell xcode-select -p 2>/dev/null),)
  $(error Xcode Command Line Tools not found. Install with: xcode-select --install)
endif

# Colors
BLUE   := \033[00;34m
GREEN  := \033[00;32m
RED    := \033[0;31m
YELLOW := \033[0;33m
RESET  := \033[0m

define INFO
	@printf "  [ $(BLUE)..$(RESET) ] $(1)\n"
endef

define OK
	@printf "  [ $(GREEN)OK$(RESET) ] $(1)\n"
endef

define FAIL
	@printf "  [$(RED)FAIL$(RESET)] $(1)\n"
endef

define BANNER
	@echo ""
	@echo ""
	@echo "██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
	@echo "██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
	@echo "██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
	@echo "██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
	@echo "██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
	@echo "╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
	@echo "                                                             "
	@echo "██████╗ ██╗   ██╗    ███╗   ██╗██╗   ██╗███╗   ██╗ ██████╗   "
	@echo "██╔══██╗╚██╗ ██╔╝    ████╗  ██║██║   ██║████╗  ██║██╔═══██╗  "
	@echo "██████╔╝ ╚████╔╝     ██╔██╗ ██║██║   ██║██╔██╗ ██║██║   ██║  "
	@echo "██╔══██╗  ╚██╔╝      ██║╚██╗██║██║   ██║██║╚██╗██║██║   ██║  "
	@echo "██████╔╝   ██║       ██║ ╚████║╚██████╔╝██║ ╚████║╚██████╔╝  "
	@echo "╚═════╝    ╚═╝       ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   "
	@echo ""
	@echo ""
endef

.PHONY: all link brew native-installs node python vim macos gitsetup clean help

all: ## Full install
	@$(MAKE) --no-print-directory banner
	@$(MAKE) --no-print-directory link
	@$(MAKE) --no-print-directory brew
	@$(MAKE) --no-print-directory node
	@$(MAKE) --no-print-directory python
	@$(MAKE) --no-print-directory native-installs
	@$(MAKE) --no-print-directory vim
	@$(MAKE) --no-print-directory macos
	@echo ""
	@printf "  $(GREEN)Installation completed! Have fun! 🔥$(RESET)\n"
	@echo ""

banner:
	$(BANNER)
	@printf "  $(GREEN)Here we go! 🚀$(RESET)\n"
	@echo ""

help: ## Show targets
	$(BANNER)
	@echo "  Usage: make [target]"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "    %-12s %s\n", $$1, $$2}'
	@echo ""

link: ## Create symlinks
	$(call INFO,Creating symlinks...)
	@ln -sf $(DOTFILES)/zshrc $(HOME)/.zshrc
	@ln -sf $(DOTFILES)/git/gitconfig $(HOME)/.gitconfig
	@ln -sf $(DOTFILES)/git/gitignore $(HOME)/.gitignore
	@ln -sf $(DOTFILES)/git/gitmessage $(HOME)/.gitmessage
	@ln -sf $(DOTFILES)/vim/vimrc $(HOME)/.vimrc
	@ln -sf $(DOTFILES)/vim/vimrc.bundles $(HOME)/.vimrc.bundles
	@ln -sf $(DOTFILES)/macos/hushlogin $(HOME)/.hushlogin
	$(call OK,Symlinks created)

brew: ## Install Homebrew packages
	$(call INFO,Installing Homebrew packages...)
	@command -v brew >/dev/null || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@$(HOMEBREW_PREFIX)/bin/brew bundle --file $(DOTFILES)/Brewfile
	$(call OK,Homebrew packages installed)

node: ## Install Node.js via n
	$(call INFO,Installing Node.js...)
	@N_PREFIX=$(HOME)/.n $(HOMEBREW_PREFIX)/bin/n latest
	$(call OK,Node.js installed)

python: ## Install Python via pyenv
	$(call INFO,Installing Python...)
	@$(HOMEBREW_PREFIX)/bin/pyenv install -s 3.13
	@$(HOMEBREW_PREFIX)/bin/pyenv global 3.13
	$(call OK,Python 3.13 installed)

native-installs: ## Run native shell installers
	$(call INFO,Running native installers...)
	@$(DOTFILES)/native-installs.sh
	$(call OK,Native installers completed)

vim: ## Install vim plugins
	$(call INFO,Installing Vim plugins...)
	@test -f $(HOME)/.vim/autoload/plug.vim || \
		curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugInstall +qa
	$(call OK,Vim plugins installed)

macos: ## Apply macOS defaults
	$(call INFO,Applying macOS defaults...)
	@$(DOTFILES)/macos/defaults.sh
	$(call OK,macOS defaults applied. Some changes require logout/restart.)

gitsetup: ## Configure git identity
	$(call INFO,Setting up git identity...)
	@test -f $(DOTFILES)/git/gitconfig.local && \
		printf "  [ $(GREEN)OK$(RESET) ] gitconfig.local already exists. Skipping.\n" || \
		(read -p "  Git name: " name; read -p "  Git email: " email; \
		sed -e "s/AUTHORNAME/$$name/g" -e "s/AUTHOREMAIL/$$email/g" \
		$(DOTFILES)/git/gitconfig.local.example > $(DOTFILES)/git/gitconfig.local && \
		printf "  [ $(GREEN)OK$(RESET) ] Git identity configured\n")
	$(call INFO,Setting up GitHub CLI...)
	@$(HOMEBREW_PREFIX)/bin/gh auth status &>/dev/null && printf "  [ $(GREEN)OK$(RESET) ] GitHub CLI already authenticated\n" || $(HOMEBREW_PREFIX)/bin/gh auth login
	@$(HOMEBREW_PREFIX)/bin/gh auth setup-git

clean: ## Remove symlinks
	$(call INFO,Removing symlinks...)
	@rm -f $(HOME)/.zshrc $(HOME)/.gitconfig $(HOME)/.gitignore \
		$(HOME)/.gitmessage $(HOME)/.vimrc $(HOME)/.vimrc.bundles \
		$(HOME)/.hushlogin
	$(call OK,Symlinks removed)
