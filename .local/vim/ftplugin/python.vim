if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl com< cms< inc< fo< ofu<"

" Indentation
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Folding
setlocal foldmethod=indent

" Ruler
set colorcolumn=81

" Coc server
call coc#config('python', {
	\ 'jediEnabled': v:true,
	\ 'linting.enabled': v:true,
	\ 'linting.pylintEnabled': v:false,
	\ 'linting.flake8Enabled': v:true,
	\ 'envFile': '${workspaceFolder}/.venv'
\ })
