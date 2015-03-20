" required for vundle "
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" plugins "

" Vundle - Plugin management
Plugin 'gmarik/vundle'

" NerdTree - File browser
Plugin 'scrooloose/nerdtree.git'
" Toggle NerdTree with F2
map <F2> :NERDTreeToggle<CR>

" Go syntax highlight
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
" jk instead of escape to exit edit mode
imap jk <Esc> 
" F3 for saving
map <F3> :w<CR>
" F4 to close window
map <F4> :q<CR>
" Tab for next window
nnoremap <Tab> <C-W>w
" Shift-Tab for previous window
nnoremap <S-Tab> <C-W>p
" Ctrl-K for new empty line above current
nmap <C-K> O<Esc>
" Ctrl-J for new empty line below current
nmap <C-J> o<Esc>
" Ctrl-n to remove search highlight
nnoremap <C-N> :noh<CR>

" Tab
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4

colorscheme monokai

" Enable line numbering
set number
" Enable incremental search as you type
set incsearch
" Enable search highlight
set hlsearch
" Enable case insensitive search
set ignorecase

" disable swp files
set nobackup

" Makefiles
:map <f9> :make<CR>
:map <f10> :cw<CR>

" Enable thick cursor when in normal mode
if has("autocmd")
	au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
	au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
	au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif
