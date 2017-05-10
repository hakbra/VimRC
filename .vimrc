" required for vundle "
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Windows
" set rtp+=%USERPROFILE%/vimfiles/bundle/Vundle.vim/
" call vundle#begin('c:/users/hkbrten/vimfiles/bundle/')

" plugins "

" Taglist
Plugin 'vim-scripts/taglist.vim'
let tlist_cs_settings = 'c#;c:class;x:cmdlet;p:property;m:method'
let tlist_ps1_settings = 'powershell;f:function'

" Vundle - Plugin management
Plugin 'gmarik/vundle'

" simple-git
Plugin 'hakbra/vim-simple-git'

" Powershell syntax
Plugin 'PProvost/vim-ps1'

" For changing between header and source
Plugin 'derekwyatt/vim-fswitch'

" Quick scope navigation
Plugin 'unblevable/quick-scope'

" Colorscheme
Plugin 'sickill/vim-monokai.git'

" Vim surround
Plugin 'tpope/vim-surround.git'

" Syntastic
Plugin 'scrooloose/syntastic.git'

" j/k jumps
Plugin 'teranex/jk-jumps.vim'
let g:jk_jumps_minimum_lines = 7

" ctrl-p
Plugin 'ctrlpvim/ctrlp.vim'
"
" Custom matcher for faster search
" Plugin 'FelikZ/ctrlp-py-matcher'
" Faster custom matcher
"
Plugin 'JazzCore/ctrlp-cmatcher'
" Mapping for finding files, mnemonic: f for files
let g:ctrlp_map = '<c-f>'
" Command invoked when doing ctrl-f
let g:ctrlp_cmd = 'CtrlP'
" Files contained in root folder, usually /dev
let g:ctrlp_root_markers = ['tags', 'cscope.files']
" Search only by filename, not in directory name, ctrl-d to temp revert
let g:ctrlp_by_filename = 1
" Disable regex for performance, ctrl-r to temp revert
let g:ctrlp_regexp = 0
" Search only files in cscope.files
let g:ctrlp_user_command = ['cscope.files', 'type %s\cscope.files']
" Use custom matcher function for perf
" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
" Method of determining root directory, see docs
let g:ctrlp_working_path_mode = 'rw'

" Taboo tab naming
Plugin 'gcmt/taboo.vim.git'
set sessionoptions+=tabpages,globals

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe.git'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
set pumheight=5

" Customized status line
Plugin 'vim-airline/vim-airline'
let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline#extensions#wordcount#enabled = 0
let g:airline_powerline_fonts=1

call vundle#end()
filetype plugin indent on

" Key combos
let mapleader=','
" jk instead of escape to exit edit mode
imap jk <Esc> 
" F3 for saving
map <Leader>w :w<CR>
" F4 to close window
map <Leader>q :q<CR>
" Tab for next window
nnoremap <Tab> <C-W>W
" Ctrl I for next jump list
nnoremap <C-P> <Tab>
" Shift-Tab for previous window
nnoremap <S-Tab> <C-W>w
" Ctrl-K for new empty line above current
nmap <C-K> O<Esc>
" Ctrl-J for new empty line below current
nmap <C-J> o<Esc>
" Ctrl-n to remove search highlight
nnoremap <C-N> :noh<CR>
" Jump to position of mark
map ' `
" Previous buffer
nnoremap  <C-^>
" open folder in explorer
map <Leader>o :!start explorer /select,%:p<CR>

" make splits
nnoremap \| <C-W>v
nnoremap § <C-W>v:term<CR>
nnoremap - <C-W>s
nnoremap _ <C-W>s:term<CR>

" GO to definition
nnoremap <Leader>d :YcmCompleter GoTo<CR>
nnoremap <Leader>f :YcmCompleter FixIt<CR>
nnoremap <Leader>h :FSHere<CR>

" Tab
set tabstop=4
set softtabstop=0
set shiftwidth=4

try
	" colorscheme monokai
	set background=dark
	colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
	" deal with it
endtry
syntax enable

set splitright
set splitbelow

" Enable line numbering
set relativenumber
set number
" Enable incremental search as you type
set incsearch
" Enable search highlight
set hlsearch
" Enable case insensitive search
set ignorecase
" Enable global search default
set gdefault

" graphic tab match
set wildmenu

" improves perf on macros
set lazyredraw

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set mouse=
set path=.,**,,

" Dictionary
set dictionary=/usr/share/dict/american-english

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=Lucida_Console:h11:cDEFAULT

set grepprg=grep\ -nH
set tags=tags;
set complete-=t

set backspace=indent,eol,start

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

set list
set listchars=tab:>-,trail:~
set ff=dos
set nowrap

let g:netrw_banner=0

" ================== Console specific ===============
" Enable thick cursor when in normal mode
if has("autocmd")
	au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
	au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
	au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif

" ================== Neovim specific ===============
if has('nvim')
	function! s:term_gf()
		let procid = matchstr(bufname(""), '\(://.*/\)\@<=\(\d\+\)')
		let proc_cwd = resolve('/proc/'.procid.'/cwd')
		exe 'lcd '.proc_cwd
		exe 'e <cfile>'
	endfunction

	au TermOpen * nmap <buffer> gf :call <SID>term_gf()<cr>

	tnoremap <ESC> <C-\><C-n>
	set noshowmode

	for f in glob('~/.config/nvim/extra/*.vim', 0, 1)
		execute 'source' f
	endfor
endif

" ================== Work specific ===============
map <Leader>to1 :cd c:\WS\Of_01\dev<CR>
map <Leader>ts1 :cd c:\WS\Se_01\dev<CR>
map <Leader>tg :cd C:\Users\hkbrten\Documents\Git<CR>

function! CheckPowershellSyntax()
    let scriptPath = "\\\\hkbrten-00\\Tools\\scripts\\powershellchecker.ps1"
    let errorString = system("powershell -noprofile " . scriptPath . " -path " . bufname("%"))
    if strlen(errorString) > 0
        echom "Found errors"
        call setqflist([])
        caddexpr errorString
        copen
    else
        echom "No errors!"
    endif
endfunction

map <Leader>p :call CheckPowershellSyntax()<CR>
