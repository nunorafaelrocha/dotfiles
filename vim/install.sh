# Install Vundle, the plug-in manager for Vim.
if [ ! -e $HOME/.vim/bundle/Vundle.vim ]; then
 git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

# Install vim Vundle plugins
vim -u $HOME/.vimrc.bundles +PluginUpdate +qa
