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

nnoremap <leader>lm :call Make()<CR>
nnoremap <leader>lc :call MakeClean()<CR>
