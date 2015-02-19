"" vundle ""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"" plugins ""

" Vundle
Plugin 'gmarik/vundle'

" NerdTree
Plugin 'scrooloose/nerdtree.git'
map <F2> :NERDTreeToggle<CR>

" Go syntax
Plugin 'geekq/vim-go.git'

" Colorscheme
Plugin 'sickill/vim-monokai.git'

" Vim surround
Plugin 'tpope/vim-surround.git'

" Syntastic
Plugin 'scrooloose/syntastic.git'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe.git'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

filetype plugin indent on


" Key combos
imap jk <Esc>
map <F3> :w<CR>
map <F4> :q<CR>
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>p
nmap <C-K> O<Esc>
nmap <C-J> o<Esc>
nnoremap <C-N> :noh<CR>

" Tab
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4

colorscheme monokai

set number
set hidden
set incsearch
set hlsearch
set ignorecase

if has("autocmd")
	au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
	au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
	au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif
