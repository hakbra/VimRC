git clone https://github.com/neovim/neovim.git
cd neovim
make
sudo make install

mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

sudo apt-get install python-pip
sudo pip2 install neovim
