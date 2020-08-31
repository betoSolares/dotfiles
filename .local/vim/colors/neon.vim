set background=dark

highlight clear
if exists("syntax_on")
	syntax reset
endif

set t_Co=256
let g:colors_name = "neon"

" Vim >= 7.0 specific colors
if version >= 700
	set cursorline
	highlight CursorLine cterm=NONE
	highlight CursorLineNr ctermfg=188 cterm=BOLD
	highlight LineNr ctermfg=59
	highlight MatchParen ctermfg=226 ctermbg=21
	highlight Pmenu ctermfg=231 ctermbg=233
	highlight PmenuSel ctermfg=233 ctermbg=231 cterm=BOLD
	highlight PmenuSbar ctermfg=NONE ctermbg=233
	highlight PmenuThumb ctermfg=231 ctermbg=233
endif

" General colors
highlight Cursor ctermbg=231
highlight Normal ctermfg=231 ctermbg=232
highlight NonText ctermfg=247 ctermbg=232
highlight Search ctermfg=21 ctermbg=226
highlight IncSearch cterm=REVERSE
highlight Visual ctermfg=46 ctermbg=21
highlight StatusLine ctermfg=232 ctermbg=33
highlight StatusLineNC ctermfg=232 ctermbg=255
highlight Directory ctermfg=226
highlight Title ctermfg=231
highlight SpecialKey ctermfg=33 ctermbg=232
highlight TabLine ctermfg=244 ctermbg=232
highlight TabLineFill ctermfg=232
highlight TabLineSel ctermfg=231 ctermbg=232 cterm=BOLD

"Linter and error checkers
highlight SpellBad ctermfg=231 ctermbg=196

" Syntax highlighting
highlight Keyword ctermfg=33
highlight Constant ctermfg=196
highlight Number ctermfg=196
highlight String ctermfg=226
highlight Function ctermfg=46 ctermbg=18
highlight Comment ctermfg=102
highlight Exception ctermfg=33 ctermbg=232
highlight Operator ctermfg=147
highlight Special ctermfg=135
highlight Delimiter ctermfg=231
highlight Boolean ctermfg=196
highlight Type ctermfg=202 ctermbg=232
highlight Identifier ctermfg=33
highlight Statement ctermfg=202
highlight Conditional ctermfg=32
highlight Repeat ctermfg=32
highlight Label ctermfg=32
highlight PreProc ctermfg=33
highlight StorageClass ctermfg=40 ctermbg=22
highlight Error ctermbg=196

