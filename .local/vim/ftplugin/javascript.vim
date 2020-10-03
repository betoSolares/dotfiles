if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl com< cms< inc< fo< ofu<"

" Indentation
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

" Ruler
set colorcolumn=80
