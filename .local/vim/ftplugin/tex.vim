if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl com< cms< inc< fo< ofu<"

" Indentation
setlocal softtabstop=4
setlocal shiftwidth=4

" Folding
setlocal foldmethod=syntax

" Ruler
set colorcolumn=100

" Compiler
map <leader>c :w! \| !texcomp "<c-r>%"<CR>

" Clean after leave vim
autocmd VimLeave *.tex !texclear %
