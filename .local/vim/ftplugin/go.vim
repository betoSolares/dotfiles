if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl com< cms< inc< fo< ofu<"

" Indentation
setlocal softtabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

" Folding
setlocal foldmethod=syntax

" Ruler
set colorcolumn=99

" Coc server
call coc#config('golang', {
	\ 'command': 'gopls',
	\ 'rootPatterns': ["go.mod", ".vim/", ".git/", ".hg/"],
	\ 'filetypes': ['go']
\ })
