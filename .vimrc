" required for vundle "
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" plugins "
"

" Vundle - Plugin management
Plugin 'gmarik/vundle'

" For changing between header and source
Plugin 'derekwyatt/vim-fswitch'

" Coffe script highlighting
Plugin 'kchmck/vim-coffee-script'

" Quick scope navigation
Plugin 'unblevable/quick-scope'

" Markdown folding
Plugin 'nelstrom/vim-markdown-folding'
let g:markdown_fold_style = 'nested'

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
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_max_diagnostics_to_display = 5

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
" Reload vimrc
map <Leader>v :source ~/.vimrc<CR>
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

" GO to definition
nnoremap <Leader>d :YcmCompleter GoTo<CR>
nnoremap <Leader>f :YcmCompleter FixIt<CR>
nnoremap <Leader>h :FSHere<CR>

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
set relativenumber
" Enable incremental search as you type
set incsearch
" Enable search highlight
set hlsearch
" Enable case insensitive search
set ignorecase
" Enable global search default
set gdefault
" Enable very magic
nnoremap / /\v
cnoremap %s/ %s/\v

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

" Enable thick cursor when in normal mode
if has("autocmd")
	au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
	au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
	au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif

if has('nvim')
	tnoremap <ESC> <C-\><C-n>

	let s:errors = []
	let s:reg = '^.*:[0-9]*:.*'
	let s:mak = '^makefile'
	function! JobHandler(job_id, data, event)
		if a:event == 'stdout'
			let new_errors = []
			for line in a:data
				let ind = index(s:errors, line)
				if line =~ s:reg && line !~ s:mak && ind < 0
					call add(s:errors, line)
					call add(new_errors, line)
					copen
				endif
			endfor
			if len(new_errors) > 0
				caddexpr new_errors
			endif
		endif
		if a:event == 'exit' && len(s:errors) == 0
			echom 'Success!'
		endif
	endfunction

	let s:callbacks = {
	\ 'on_stdout': function('JobHandler'),
	\ 'on_stderr': function('JobHandler'),
	\ 'on_exit': function('JobHandler')
	\ }

	function! Make()
		w
		cclose
		call setqflist([])
		let s:errors = []
		call jobstart(['make'], s:callbacks)
	endfunction

	nnoremap <leader>mk :call Make()<CR>
endif
