cp ~/.vimrc ~/.vimrc.bck
rm ~/.vimrc
rm -rf ~/.vim

ln -s $(pwd)/.vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
~/.vim/bundle/YouCompleteMe/install.py --clang-completer
cp .ycm_extra_conf.py ~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py
