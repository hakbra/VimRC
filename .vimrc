" required for vundle "
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" plugins "
"

" FOr changing between header and source
Plugin 'derekwyatt/vim-fswitch'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Coffe script highlighting
Plugin 'kchmck/vim-coffee-script'

" Quick scope navigation
Plugin 'unblevable/quick-scope'

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

" Taboo
Plugin 'gcmt/taboo.vim.git'
set sessionoptions+=tabpages,globals

" YouCompleteMe
 Plugin 'Valloric/YouCompleteMe.git'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_max_diagnostics_to_display = 5

call vundle#end()
filetype plugin indent on

" Key combos
let mapleader=','
" jk instead of escape to exit edit mode
imap jk <Esc> 
" F3 for saving
map <F3> :w<CR>
" F4 to close window
map <F4> :q<CR>
" Tab for next window
nnoremap <Tab> <C-W>w
" Shift-Tab for previous window
nnoremap <S-Tab> <C-W>W
" Ctrl-K for new empty line above current
nmap <C-K> O<Esc>
" Ctrl-J for new empty line below current
nmap <C-J> o<Esc>
" Ctrl-n to remove search highlight
nnoremap <C-N> :noh<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Exit terminal mode
if has('nvim')
	tnoremap <ESC> <C-\><C-n>
endif
" GO to definition
nnoremap <Leader>d :YcmCompleter GoTo<CR>
nnoremap <Leader>f :YcmCompleter FixIt<CR>
nnoremap <Leader>h :FSHere<CR>
nnoremap Q @q

set splitbelow
set splitright 

" Tab
set tabstop=4
set softtabstop=0
set shiftwidth=4

try
	colorscheme monokai
catch /^Vim\%((\a\+)\)\=:E185/
	" deal with it
endtry
syntax enable

" Enable line numbering
set number
" Enable incremental search as you type
set incsearch
" Enable search highlight
set hlsearch
" Enable case insensitive search
set ignorecase
" Enable global search default
set gdefault

" disable swp files
set nobackup

" graphic tab match
set wildmenu
" improves perf on macros
set lazyredraw

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> zA
set foldmethod=indent

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set mouse=

" Makefiles
:map <f9> :make<CR>
:map <f10> :cw<CR>

" Enable thick cursor when in normal mode
if has("autocmd")
	au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
	au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
	au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif
