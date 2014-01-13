" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2006 Apr 15

" This color scheme uses a light grey background.

" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "b2"

hi Normal ctermfg=Black ctermbg=LightGrey guifg=Black guibg=grey90

" Groups used in the 'highlight' and 'guicursor' options default value.
hi ErrorMsg term=standout ctermbg=DarkRed ctermfg=White guibg=Red guifg=White
hi IncSearch term=reverse cterm=reverse gui=reverse
hi ModeMsg term=bold cterm=bold gui=bold
hi StatusLine term=reverse,bold cterm=reverse,bold gui=reverse,bold
hi StatusLineNC term=reverse cterm=reverse gui=reverse
hi VertSplit term=reverse cterm=reverse gui=reverse
hi Visual term=reverse ctermbg=grey guibg=grey80
hi VisualNOS term=underline,bold cterm=underline,bold gui=underline,bold
hi DiffText term=reverse cterm=bold ctermfg=Red ctermbg=Yellow gui=bold guibg=Red
hi Cursor guibg=Green guifg=NONE
hi lCursor guibg=Cyan guifg=NONE
hi Directory term=bold ctermfg=DarkBlue guifg=Blue
hi LineNr term=underline ctermfg=Gray guifg=Brown
hi MoreMsg term=bold ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi NonText term=bold ctermfg=Blue gui=bold guifg=Blue guibg=grey80
hi Question term=standout ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi Search term=reverse ctermbg=Yellow ctermfg=NONE guibg=Yellow guifg=NONE
hi SpecialKey term=bold ctermfg=DarkBlue guifg=Blue
hi Title term=bold ctermfg=DarkMagenta gui=bold guifg=Magenta
hi WarningMsg term=standout ctermfg=DarkRed guifg=Red
hi WildMenu term=standout ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi Folded term=standout ctermbg=Grey ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi FoldColumn term=standout ctermbg=Grey ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
hi DiffAdd term=bold ctermbg=LightBlue guibg=LightBlue
hi DiffChange term=bold ctermbg=LightMagenta cterm=None guibg=LightMagenta
hi DiffDelete term=bold ctermfg=Blue ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan
hi CursorLine term=underline cterm=underline guibg=grey80
hi CursorColumn term=reverse ctermbg=Magenta guibg=grey80
"	bezet - 12.02.2013
hi SpellBad ctermfg=Red cterm=bold
"	bezet - 25.04.2013
hi MatchParen cterm=bold ctermfg=Magenta ctermbg=LightBlue

" Colors for syntax highlighting
hi Comment term=bold ctermfg=DarkGray guifg=Gray
hi PreProc term=underline ctermfg=DarkMagenta guifg=DarkMagenta
hi Constant ctermfg=Red cterm=None guifg=Brown
"hi Statement ctermfg=Brown cterm=Bold gui=NONE guifg=Brown
hi Keyword ctermfg=Red cterm=None gui=NONE guifg=Brown
hi Type term=underline ctermfg=Blue cterm=bold gui=NONE guifg=Blue
hi Identifier term=underline ctermfg=Blue guifg=Blue
hi Function term=underline ctermfg=Blue cterm=bold guifg=Blue
hi Special term=bold ctermfg=DarkRed guifg=DarkRed
hi Todo term=standout ctermbg=Yellow cterm=bold guifg=Blue guibg=Yellow

hi Tag term=bold ctermfg=DarkGreen guifg=DarkGreen
hi Error term=reverse ctermfg=15 ctermbg=9 guibg=Red guifg=White
hi link String		Constant
hi link Character	Constant
hi link Number		Constant
hi link Boolean		Constant
hi link SpecialChar	Constant

hi link Float		Number

hi link Include		PreProc
hi link Define		PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc

hi link StorageClass	Type
hi link Structure		Type
hi link Typedef			Type

hi link Delimiter		Special
hi link SpecialComment 	Special
hi link Debug			Special
