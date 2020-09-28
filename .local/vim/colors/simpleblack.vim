scriptencoding utf-8

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256
let g:colors_name="simpleblack"

" ==========================
" Highlighting Function
" ==========================
fun! <sid>hi(group, fg, bg, attr)
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" .  a:fg.cterm256
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" .  a:bg.cterm256
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

let s:simpleBlack = {'gui': '#000000', 'cterm256': '232'}
let s:simpleBlack2 = {'gui': '#121212', 'cterm256': '233'}

let s:simpleGray = {'gui': '#262626', 'cterm256': '235'}
let s:simpleGray2 = {'gui': '#3a3a3a', 'cterm256': '237'}
let s:simpleGray3 = {'gui': '#4e4e4e', 'cterm256': '239'}
let s:simpleGray4 = {'gui': '#626262', 'cterm256': '241'}

let s:simpleSteel = {'gui': '#DEDEDE', 'cterm256': '253'}
let s:simpleWhite = {'gui': '#F8F8F8', 'cterm256': '231'}
let s:simpleIndianRed = {'gui': '#ff5f87', 'cterm256': '204'}

let s:simpleLightBlue = {'gui': '#afd7ff', 'cterm256': '153'}
let s:simpleBlue = {'gui': '#5f87af', 'cterm256': '67'}
let s:simpleBlue2 = {'gui': '#91AADF', 'cterm256': '110'}

let s:simpleGreen = {'gui': '#57BA37', 'cterm256': '71'}
let s:simpleGoo = {'gui': '#D8FA3B', 'cterm256': '191'}
let s:simpleGold = {'gui': '#F0D50C', 'cterm256': '220'}
let s:simpleOrange = {'gui': '#ff8700', 'cterm256': '208'}
let s:simpleRed = {'gui': '#821A1A', 'cterm256': '1'}
let s:simpleRed2 = {'gui': '#FF0000', 'cterm256': '196'}
let s:none = {'gui': 'NONE', 'cterm256': 'NONE'}

" ==========================
" Definitions
" ==========================
"    <sid>hi(GROUP, FOREGROUND, BACKGROUND, ATTRIBUTE)

au BufEnter * setlocal cursorline
au BufLeave * setlocal nocursorline

" Editor
call <sid>hi('ColorColumn', s:none, s:simpleBlack2, 'none')
call <sid>hi('Cursor', s:none, s:simpleSteel, 'none')
call <sid>hi('CursorColumn', s:none, s:simpleBlack2, 'none')
call <sid>hi('CursorLine', s:none, s:simpleBlack2, 'none')
call <sid>hi('CursorLineNr', s:simpleWhite, s:simpleBlack2, 'bold')
call <sid>hi('Directory', s:simpleBlue, s:simpleBlack, 'none')
call <sid>hi('Folded', s:simpleGray3, s:none, 'none')
call <sid>hi('LineNr', s:simpleGray, s:simpleBlack, 'none')
call <sid>hi('SignColumn', s:simpleBlue2, s:simpleBlack, 'none')
call <sid>hi('Normal', s:simpleSteel, s:simpleBlack, 'none')
call <sid>hi('MatchParen', s:simpleWhite, s:simpleBlue2, 'none')
call <sid>hi('Pmenu', s:none, s:simpleBlack, 'none')
call <sid>hi('PmenuSel', s:none, s:simpleGray2, 'bold')
call <sid>hi('Search', s:simpleBlack, s:simpleBlue, 'none')
call <sid>hi('IncSearch', s:simpleBlack, s:simpleBlue, 'none')
call <sid>hi('StatusLine', s:simpleBlue2, s:simpleBlack, 'none')
call <sid>hi('VertSplit', s:simpleWhite, s:simpleBlack, 'none')
call <sid>hi('Visual', s:none, s:simpleGray2, 'none')

call <sid>hi('TabLine', s:simpleGray4, s:simpleBlack, 'none')
call <sid>hi('TabLineFill', s:none, s:simpleBlack, 'none')
call <sid>hi('TabLineSel', s:simpleBlue, s:simpleBlack, 'none')

" General
call <sid>hi('Boolean', s:simpleGoo, s:none, 'none')
call <sid>hi('Character', s:simpleGoo, s:none, 'none')
call <sid>hi('Comment', s:simpleBlue, s:none, 'none')
call <sid>hi('Conditional', s:simpleLightBlue, s:none, 'none')
call <sid>hi('Constant', s:simpleOrange, s:none, 'none')
call <sid>hi('Define', s:simpleLightBlue, s:none, 'none')
call <sid>hi('ErrorMsg', s:simpleWhite, s:simpleRed, 'none')
call <sid>hi('Float', s:simpleGoo, s:none, 'none')
call <sid>hi('Function', s:simpleBlue2, s:none, 'none')
call <sid>hi('Identifier', s:simpleGold, s:none, 'none')
call <sid>hi('Keyword', s:simpleLightBlue, s:none, 'none')
call <sid>hi('Label', s:simpleSteel, s:none, 'none')
call <sid>hi('NonText', s:simpleGray, s:simpleBlack, 'none')
call <sid>hi('Number', s:simpleGoo, s:none, 'none')
call <sid>hi('Operator', s:simpleIndianRed, s:none, 'none')
call <sid>hi('PreProc', s:simpleIndianRed, s:none, 'none')
call <sid>hi('Special', s:simpleIndianRed, s:none, 'none')
call <sid>hi('SpecialKey', s:simpleGray, s:simpleBlack, 'none')
call <sid>hi('SpellBad', s:none, s:none, 'undercurl')
call <sid>hi('SpellCap', s:none, s:none, 'undercurl')
call <sid>hi('SpellLocal', s:none, s:none, 'undercurl')
call <sid>hi('Statement', s:simpleIndianRed, s:none, 'none')
call <sid>hi('StorageClass', s:simpleGold, s:none, 'none')
call <sid>hi('String', s:simpleGreen, s:none, 'none')
call <sid>hi('Tag', s:simpleGold, s:none, 'none')
call <sid>hi('Title', s:none, s:none, 'bold')
call <sid>hi('Todo', s:simpleBlue2, s:none, 'bold')
call <sid>hi('Type', s:simpleOrange, s:none, 'none')
call <sid>hi('Underlined', s:none, s:none, 'underline')
call <sid>hi('WarningMsg', s:simpleWhite, s:simpleRed, 'none')

" Diff Mode
if &diff
  call <sid>hi('DiffAdd', s:simpleBlack, s:simpleGreen, 'none')
  call <sid>hi('DiffChange', s:simpleBlack, s:simpleGold, 'none')
  call <sid>hi('DiffDelete', s:simpleRed2, s:simpleRed, 'none')
  call <sid>hi('DiffText', s:simpleGray, s:simpleBlue2, 'none')
else
  call <sid>hi('DiffAdd', s:simpleGreen, s:none, 'none')
  call <sid>hi('DiffChange', s:simpleGold, s:none, 'none')
  call <sid>hi('DiffDelete', s:simpleRed2, s:none, 'none')
  call <sid>hi('DiffText', s:simpleSteel, s:simpleBlue2, 'none')
endif

let $FZF_DEFAULT_OPTS='
	\ --reverse
	\ --color=fg:#5f87af,bg:#080808,hl:#5f87af
	\ --color=fg+:#f0d50c,bg+:#121212,hl+:#f0d50c
	\ --color=info:#ff8700,prompt:#57ba37,pointer:#ff5787
	\ --color=marker:#57ba37,spinner:#ff5787,header:#dedede'
