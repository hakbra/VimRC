cp ~/.vimrc ~/.vimrc.bck
rm ~/.vimrc
rm -rf ~/.vim

ln -s .vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
~/.vim/YouCompleteMe/install.py --clang-completer
cp .ycm_extra_conf.py ~/.vim/YouCompleteMe/.ycm_extra_conf.py
