" required for vundle "
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" plugins "

" Vundle - Plugin management
Plugin 'gmarik/vundle'

" simple-git
Plugin 'hakbra/vim-simple-git'

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

" True color colorscheme
Plugin 'frankier/neovim-colors-solarized-truecolor-only'

" Vim surround
Plugin 'tpope/vim-surround.git'

" Syntastic
Plugin 'scrooloose/syntastic.git'

" j/k jumps
Plugin 'teranex/jk-jumps.vim'
let g:jk_jumps_minimum_lines = 7

" Taboo
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

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

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
" Enable very magic
nnoremap / /\v
cnoremap %s/ %s/\v

" disable swp files
set nobackup
set nojoinspaces

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
	function! s:term_gf()
		let procid = matchstr(bufname(""), '\(://.*/\)\@<=\(\d\+\)')
		let proc_cwd = resolve('/proc/'.procid.'/cwd')
		exe 'lcd '.proc_cwd
		exe 'e <cfile>'
	endfunction

	au TermOpen * nmap <buffer> gf :call <SID>term_gf()<cr>

	tnoremap <ESC> <C-\><C-n>
	set noshowmode

	let g:async_make_errors = []

	function! LatexError(line)
		let s:reg = '^.*:[0-9]*:.*'
		let s:mak = '^makefile'
		if a:line =~ s:reg && a:line !~ s:mak
			return [a:line]
		endif
		return []
	endfunction

	function! ReferenceError(line)
		let s:bib = "^WARN"
		if a:line =~ s:bib
			let refs = split(a:line, "'")
			if len(refs) >= 3
				let ref = refs[2]
				let output = system('grep -rn "{'.ref.'}" *.tex')
				let hits = split(output, '\n')
				echom join(hits, "HH")
				return hits
			endif
		endif
		return []
	endfunction

	let g:make_filter_functions = [function('LatexError'), function('ReferenceError')]

	function! MakeHandlerStdout(job_id, data, event)
		echom 'Making'
		if a:event == 'stdout'
			for line in a:data

				let ind = index(g:async_make_errors, line)

				if ind >= 0
					continue
				endif

				for Func in g:make_filter_functions
					let ret = Func(line)
					for r in ret
						caddexpr r
						call add(g:async_make_errors, r)
						copen
					endfor
				endfor

			endfor
		endif
		if a:event == 'exit' && len(g:async_make_errors) == 0
			echom 'Success!'
		endif
	endfunction

	function! MakeHandlerExit(job_id, data, event)
		if len(g:async_make_errors) == 0
			echom 'Success!'
		endif
	endfunction

	let s:callbacks = {
	\ 'on_stdout': function('MakeHandlerStdout'),
	\ 'on_exit': function('MakeHandlerExit')
	\ }

	function! Make()
		cclose
		call setqflist([])
		let g:async_make_errors = []
		call jobstart(['make'], s:callbacks)
	endfunction

	function! MakeClean()
		echom 'Make clean'
		cclose
		call setqflist([])
		let g:async_make_errors = []
		call jobstart(['make', 'clean'])
	endfunction


	nnoremap <leader>mk :call Make()<CR>
	nnoremap <leader>mc :call MakeClean()<CR>
endif
