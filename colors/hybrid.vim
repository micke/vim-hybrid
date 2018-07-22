" -----------------------------------------------------------------------------
" File: hybrid-redux.vim
" Description: Hybrid originally created by https://github.com/w0ng. Vimscript
" from gruvbox: https://github.com/morhetz/gruvbox
" Author: lisinge <me@mike.gg>
" Source: https://github.com/lisinge/vim-hybrid-redux
" Based On: https://github.com/w0ng/vim-hybrid and https://github.com/morhetz/gruvbox
" License: MIT
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='hybrid'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:hybrid_bold')
  let g:hybrid_bold=1
endif
if !exists('g:hybrid_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:hybrid_italic=1
  else
    let g:hybrid_italic=0
  endif
endif
if !exists('g:hybrid_undercurl')
  let g:hybrid_undercurl=1
endif
if !exists('g:hybrid_underline')
  let g:hybrid_underline=1
endif
if !exists('g:hybrid_inverse')
  let g:hybrid_inverse=1
endif

if !exists('g:hybrid_guisp_fallback') || index(['fg', 'bg'], g:hybrid_guisp_fallback) == -1
  let g:hybrid_guisp_fallback='NONE'
endif

if !exists('g:hybrid_improved_strings')
  let g:hybrid_improved_strings=0
endif

if !exists('g:hybrid_improved_warnings')
  let g:hybrid_improved_warnings=0
endif

if !exists('g:hybrid_termcolors')
  let g:hybrid_termcolors=256
endif

if exists('g:hybrid_contrast')
  echo 'g:hybrid_contrast is deprecated; use g:hybrid_contrast_light and g:hybrid_contrast_dark instead'
endif

if !exists('g:hybrid_contrast_dark')
  let g:hybrid_contrast_dark='medium'
endif

if !exists('g:hybrid_contrast_light')
  let g:hybrid_contrast_light='medium'
endif
if !exists('g:hybrid_transparent')
  let g:hybrid_transparent=0
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard        = ['#1d1f21',   234]
let s:gb.dark0             = ['#1d1f21',   234]
let s:gb.dark0_transparent = ['#1d1f21f2', 234]
let s:gb.dark0_soft        = ['#1d1f21',   234]
let s:gb.dark1             = ['#282a2e',   235]
let s:gb.dark2             = ['#585c63',   239]
let s:gb.dark3             = ['#707880',   237]
let s:gb.dark4             = ['#c5c8c6',   250]
let s:gb.dark4_256         = ['#7c6f64',   243]

let s:gb.gray_245    = ['#707880', 245]
let s:gb.gray_244    = ['#707880', 244]

let s:gb.light0_hard = ['#585c63', 250]
let s:gb.light0      = ['#585c63', 250]
let s:gb.light0_soft = ['#585c63', 250]
let s:gb.light1      = ['#c5c8c6', 223]
let s:gb.light2      = ['#9e9e9e', 250]
let s:gb.light3      = ['#808080', 248]
let s:gb.light4      = ['#425059', 246]
let s:gb.light4_256  = ['#425059', 246]

let s:gb.add         = ['#5F875F', 0]
let s:gb.change      = ['#5F5F87', 0]
let s:gb.del         = ['#cc6666', 0]

let s:gb.bright_red     = ['#cc6666', 167]
let s:gb.bright_green   = ['#b5bd68', 142]
let s:gb.bright_yellow  = ['#f0c674', 214]
let s:gb.bright_blue    = ['#81a2be', 109]
let s:gb.bright_purple  = ['#b294bb', 175]
let s:gb.bright_aqua    = ['#8abeb7', 108]
let s:gb.bright_orange  = ['#de935f', 208]

let s:gb.neutral_red    = ['#cc6666', 124]
let s:gb.neutral_green  = ['#b5bd68', 106]
let s:gb.neutral_yellow = ['#f0c674', 172]
let s:gb.neutral_blue   = ['#81a2be', 66] 
let s:gb.neutral_purple = ['#b294bb', 132]
let s:gb.neutral_aqua   = ['#8abeb7', 72] 
let s:gb.neutral_orange = ['#de935f', 166]

let s:gb.faded_red      = ['#5f0000', 88] 
let s:gb.faded_green    = ['#005f00', 100]
let s:gb.faded_yellow   = ['#5f5f00', 136]
let s:gb.faded_blue     = ['#00005f', 24] 
let s:gb.faded_purple   = ['#5f005f', 96] 
let s:gb.faded_aqua     = ['#005f5f', 66] 
let s:gb.faded_orange   = ['#875f00', 130]

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:hybrid_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:hybrid_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:hybrid_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:hybrid_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:hybrid_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  if g:hybrid_transparent == 0
    let s:bg0  = s:gb.dark0
  else
    let s:bg0  = s:gb.dark0_transparent
  end

  if g:hybrid_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:hybrid_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:addbg  = s:gb.add
  let s:changebg  = s:gb.change
  let s:delbg  = s:gb.del

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:addfg = ['#d7ffaf', 0]
  let s:changefg = ['#d7d7ff', 0]

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:hybrid_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:hybrid_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:hybrid_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.addfg = s:addfg
let s:gb.changefg = s:changefg

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:hybrid_hls_cursor')
  let s:hls_cursor = get(s:gb, g:hybrid_hls_cursor)
endif

let s:number_column = s:none
if exists('g:hybrid_number_column')
  let s:number_column = get(s:gb, g:hybrid_number_column)
endif

let s:sign_column = s:bg0

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:hybrid_sign_column')
    let s:sign_column = get(s:gb, g:hybrid_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:hybrid_color_column')
  let s:color_column = get(s:gb, g:hybrid_color_column)
endif

let s:vert_split = s:bg0
if exists('g:hybrid_vert_split')
  let s:vert_split = get(s:gb, g:hybrid_vert_split)
endif

let s:invert_signs = ''
if exists('g:hybrid_invert_signs')
  if g:hybrid_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:hybrid_invert_selection')
  if g:hybrid_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:hybrid_invert_tabline')
  if g:hybrid_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:hybrid_italicize_comments')
  if g:hybrid_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:hybrid_italicize_strings')
  if g:hybrid_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:hybrid_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:hybrid_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Hybrid Hi Groups: {{{

" memoize common hi groups
call s:HL('HybridFg0', s:fg0)
call s:HL('HybridFg1', s:fg1)
call s:HL('HybridFg2', s:fg2)
call s:HL('HybridFg3', s:fg3)
call s:HL('HybridFg4', s:fg4)
call s:HL('HybridAddFg', s:addfg)
call s:HL('HybridChangeFg', s:changefg)
call s:HL('HybridGray', s:gray)
call s:HL('HybridBg0', s:bg0)
call s:HL('HybridBg1', s:bg1)
call s:HL('HybridBg2', s:bg2)
call s:HL('HybridBg3', s:bg3)
call s:HL('HybridBg4', s:bg4)
call s:HL('HybridAddBg', s:addbg)
call s:HL('HybridChangeBg', s:changebg)

call s:HL('HybridRed', s:red)
call s:HL('HybridRedBold', s:red, s:none, s:bold)
call s:HL('HybridGreen', s:green)
call s:HL('HybridGreenBold', s:green, s:none, s:bold)
call s:HL('HybridYellow', s:yellow)
call s:HL('HybridYellowBold', s:yellow, s:none, s:bold)
call s:HL('HybridBlue', s:blue)
call s:HL('HybridBlueBold', s:blue, s:none, s:bold)
call s:HL('HybridPurple', s:purple)
call s:HL('HybridPurpleBold', s:purple, s:none, s:bold)
call s:HL('HybridAqua', s:aqua)
call s:HL('HybridAquaBold', s:aqua, s:none, s:bold)
call s:HL('HybridOrange', s:orange)
call s:HL('HybridOrangeBold', s:orange, s:none, s:bold)

call s:HL('HybridRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('HybridGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('HybridYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('HybridBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('HybridPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('HybridAquaSign', s:aqua, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/hybrid/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:none, s:inverse)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText HybridBg2
hi! link SpecialKey HybridBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg1, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory HybridGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title HybridGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg HybridYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg HybridYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question HybridOrangeBold
" Warning messages
hi! link WarningMsg HybridRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg2, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:hybrid_improved_strings == 0
  hi! link Special HybridOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement HybridBlue
" if, then, else, endif, swicth, etc.
hi! link Conditional HybridBlue
" for, do, while, etc.
hi! link Repeat HybridRed
" case, default, etc.
hi! link Label HybridRed
" try, catch, throw
hi! link Exception HybridRed
" sizeof, "+", "*", etc.
call s:HL('Operator', s:fg1, s:none)
" Any other keyword
hi! link Keyword HybridRed

" Variable name
hi! link Identifier HybridPurple
" Function name
hi! link Function HybridYellowBold

" Generic preprocessor
hi! link PreProc HybridAqua
" Preprocessor #include
hi! link Include HybridAqua
" Preprocessor #define
hi! link Define HybridAqua
" Same as Define
hi! link Macro HybridAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit HybridAqua

" Generic constant
hi! link Constant HybridRed
" Character constant: 'c', '/n'
hi! link Character HybridPurple
" String constant: "this is a string"
if g:hybrid_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean HybridPurple
" Number constant: 234, 0xff
hi! link Number HybridYellow
" Floating point constant: 2.3e10
hi! link Float HybridPurple

" Generic type
hi! link Type HybridOrange
" static, register, volatile, etc
hi! link StorageClass HybridOrange
" struct, union, enum, etc.
hi! link Structure HybridAqua
" typedef
hi! link Typedef HybridYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:fg1, s:delbg)
call s:HL('DiffAdd',    s:addfg, s:addbg)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:changefg, s:changebg, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:hybrid_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  call s:HL('IndentGuidesOdd', s:vim_bg, s:bg1)
  call s:HL('IndentGuidesEven', s:vim_bg, s:bg0)
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd HybridGreenSign
hi! link GitGutterChange HybridAquaSign
hi! link GitGutterDelete HybridRedSign
hi! link GitGutterChangeDelete HybridAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile HybridGreen
hi! link gitcommitDiscardedFile HybridRed

" }}}
" Signify: {{{

hi! link SignifySignAdd HybridGreenSign
hi! link SignifySignChange HybridAquaSign
hi! link SignifySignDelete HybridRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign HybridRedSign
hi! link SyntasticWarningSign HybridYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   HybridBlueSign
hi! link SignatureMarkerText HybridPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl HybridBlueSign
hi! link ShowMarksHLu HybridBlueSign
hi! link ShowMarksHLo HybridBlueSign
hi! link ShowMarksHLm HybridBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch HybridYellow
hi! link CtrlPNoEntries HybridRed
hi! link CtrlPPrtBase HybridBg2
hi! link CtrlPPrtCursor HybridBlue
hi! link CtrlPLinePre HybridBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket HybridFg3
hi! link StartifyFile HybridFg1
hi! link StartifyNumber HybridBlue
hi! link StartifyPath HybridGray
hi! link StartifySlash HybridGray
hi! link StartifySection HybridYellow
hi! link StartifySpecial HybridBg2
hi! link StartifyHeader HybridOrange
hi! link StartifyFooter HybridBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign HybridRedSign
hi! link ALEWarningSign HybridYellowSign
hi! link ALEInfoSign HybridBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail HybridAqua
hi! link DirvishArg HybridYellow

" }}}
" Netrw: {{{

hi! link netrwDir HybridAqua
hi! link netrwClassify HybridAqua
hi! link netrwLink HybridGray
hi! link netrwSymLink HybridFg1
hi! link netrwExe HybridYellow
hi! link netrwComment HybridGray
hi! link netrwList HybridBlue
hi! link netrwHelpCmd HybridAqua
hi! link netrwCmdSep HybridFg3
hi! link netrwVersion HybridGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir HybridAqua
hi! link NERDTreeDirSlash HybridAqua

hi! link NERDTreeOpenable HybridOrange
hi! link NERDTreeClosable HybridOrange

hi! link NERDTreeFile HybridFg1
hi! link NERDTreeExecFile HybridYellow

hi! link NERDTreeUp HybridGray
hi! link NERDTreeCWD HybridGreen
hi! link NERDTreeHelp HybridFg1

hi! link NERDTreeToggleOn HybridGreen
hi! link NERDTreeToggleOff HybridRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded HybridGreen
hi! link diffRemoved HybridRed
hi! link diffChanged HybridAqua

hi! link diffFile HybridOrange
hi! link diffNewFile HybridYellow

hi! link diffLine HybridBlue

" }}}
" Html: {{{

hi! link htmlTag HybridBlue
hi! link htmlEndTag HybridBlue

hi! link htmlTagName HybridAquaBold
hi! link htmlArg HybridAqua

hi! link htmlScriptTag HybridPurple
hi! link htmlTagN HybridFg1
hi! link htmlSpecialTagName HybridAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar HybridOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag HybridBlue
hi! link xmlEndTag HybridBlue
hi! link xmlTagName HybridBlue
hi! link xmlEqual HybridBlue
hi! link docbkKeyword HybridAquaBold

hi! link xmlDocTypeDecl HybridGray
hi! link xmlDocTypeKeyword HybridPurple
hi! link xmlCdataStart HybridGray
hi! link xmlCdataCdata HybridPurple
hi! link dtdFunction HybridGray
hi! link dtdTagName HybridPurple

hi! link xmlAttrib HybridAqua
hi! link xmlProcessingDelim HybridGray
hi! link dtdParamEntityPunct HybridGray
hi! link dtdParamEntityDPunct HybridGray
hi! link xmlAttribPunct HybridGray

hi! link xmlEntity HybridOrange
hi! link xmlEntityPunct HybridOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation HybridOrange
hi! link vimBracket HybridOrange
hi! link vimMapModKey HybridOrange
hi! link vimFuncSID HybridFg3
hi! link vimSetSep HybridFg3
hi! link vimSep HybridFg3
hi! link vimContinue HybridFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword HybridBlue
hi! link clojureCond HybridOrange
hi! link clojureSpecial HybridOrange
hi! link clojureDefine HybridOrange

hi! link clojureFunc HybridYellow
hi! link clojureRepeat HybridYellow
hi! link clojureCharacter HybridAqua
hi! link clojureStringEscape HybridAqua
hi! link clojureException HybridRed

hi! link clojureRegexp HybridAqua
hi! link clojureRegexpEscape HybridAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen HybridFg3
hi! link clojureAnonArg HybridYellow
hi! link clojureVariable HybridBlue
hi! link clojureMacro HybridOrange

hi! link clojureMeta HybridYellow
hi! link clojureDeref HybridYellow
hi! link clojureQuote HybridYellow
hi! link clojureUnquote HybridYellow

" }}}
" C: {{{

hi! link cOperator HybridPurple
hi! link cStructure HybridOrange

" }}}
" Python: {{{

hi! link pythonBuiltin HybridOrange
hi! link pythonBuiltinObj HybridOrange
hi! link pythonBuiltinFunc HybridOrange
hi! link pythonFunction HybridAqua
hi! link pythonDecorator HybridRed
hi! link pythonInclude HybridBlue
hi! link pythonImport HybridBlue
hi! link pythonRun HybridBlue
hi! link pythonCoding HybridBlue
hi! link pythonOperator HybridRed
hi! link pythonException HybridRed
hi! link pythonExceptions HybridPurple
hi! link pythonBoolean HybridPurple
hi! link pythonDot HybridFg3
hi! link pythonConditional HybridRed
hi! link pythonRepeat HybridRed
hi! link pythonDottedName HybridGreenBold

" }}}
" CSS: {{{

hi! link cssBraces HybridBlue
hi! link cssFunctionName HybridYellow
hi! link cssIdentifier HybridOrange
hi! link cssClassName HybridGreen
hi! link cssColor HybridBlue
hi! link cssSelectorOp HybridBlue
hi! link cssSelectorOp2 HybridBlue
hi! link cssImportant HybridGreen
hi! link cssVendor HybridFg1

hi! link cssTextProp HybridAqua
hi! link cssAnimationProp HybridAqua
hi! link cssUIProp HybridYellow
hi! link cssTransformProp HybridAqua
hi! link cssTransitionProp HybridAqua
hi! link cssPrintProp HybridAqua
hi! link cssPositioningProp HybridYellow
hi! link cssBoxProp HybridAqua
hi! link cssFontDescriptorProp HybridAqua
hi! link cssFlexibleBoxProp HybridAqua
hi! link cssBorderOutlineProp HybridAqua
hi! link cssBackgroundProp HybridAqua
hi! link cssMarginProp HybridAqua
hi! link cssListProp HybridAqua
hi! link cssTableProp HybridAqua
hi! link cssFontProp HybridAqua
hi! link cssPaddingProp HybridAqua
hi! link cssDimensionProp HybridAqua
hi! link cssRenderProp HybridAqua
hi! link cssColorProp HybridAqua
hi! link cssGeneratedContentProp HybridAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces HybridFg1
hi! link javaScriptFunction HybridAqua
hi! link javaScriptIdentifier HybridRed
hi! link javaScriptMember HybridBlue
hi! link javaScriptNumber HybridPurple
hi! link javaScriptNull HybridPurple
hi! link javaScriptParens HybridFg3

" }}}
" YAJS: {{{

hi! link javascriptImport HybridAqua
hi! link javascriptExport HybridAqua
hi! link javascriptClassKeyword HybridAqua
hi! link javascriptClassExtends HybridAqua
hi! link javascriptDefault HybridAqua

hi! link javascriptClassName HybridYellow
hi! link javascriptClassSuperName HybridYellow
hi! link javascriptGlobal HybridYellow

hi! link javascriptEndColons HybridFg1
hi! link javascriptFuncArg HybridFg1
hi! link javascriptGlobalMethod HybridFg1
hi! link javascriptNodeGlobal HybridFg1
hi! link javascriptBOMWindowProp HybridFg1
hi! link javascriptArrayMethod HybridFg1
hi! link javascriptArrayStaticMethod HybridFg1
hi! link javascriptCacheMethod HybridFg1
hi! link javascriptDateMethod HybridFg1
hi! link javascriptMathStaticMethod HybridFg1

" hi! link javascriptProp HybridFg1
hi! link javascriptURLUtilsProp HybridFg1
hi! link javascriptBOMNavigatorProp HybridFg1
hi! link javascriptDOMDocMethod HybridFg1
hi! link javascriptDOMDocProp HybridFg1
hi! link javascriptBOMLocationMethod HybridFg1
hi! link javascriptBOMWindowMethod HybridFg1
hi! link javascriptStringMethod HybridFg1

hi! link javascriptVariable HybridOrange
" hi! link javascriptVariable HybridRed
" hi! link javascriptIdentifier HybridOrange
" hi! link javascriptClassSuper HybridOrange
hi! link javascriptIdentifier HybridOrange
hi! link javascriptClassSuper HybridOrange

" hi! link javascriptFuncKeyword HybridOrange
" hi! link javascriptAsyncFunc HybridOrange
hi! link javascriptFuncKeyword HybridAqua
hi! link javascriptAsyncFunc HybridAqua
hi! link javascriptClassStatic HybridOrange

hi! link javascriptOperator HybridRed
hi! link javascriptForOperator HybridRed
hi! link javascriptYield HybridRed
hi! link javascriptExceptions HybridRed
hi! link javascriptMessage HybridRed

hi! link javascriptTemplateSB HybridAqua
hi! link javascriptTemplateSubstitution HybridFg1

" hi! link javascriptLabel HybridBlue
" hi! link javascriptObjectLabel HybridBlue
" hi! link javascriptPropertyName HybridBlue
hi! link javascriptLabel HybridFg1
hi! link javascriptObjectLabel HybridFg1
hi! link javascriptPropertyName HybridFg1

hi! link javascriptLogicSymbols HybridFg1
hi! link javascriptArrowFunc HybridYellow

hi! link javascriptDocParamName HybridFg4
hi! link javascriptDocTags HybridFg4
hi! link javascriptDocNotation HybridFg4
hi! link javascriptDocParamType HybridFg4
hi! link javascriptDocNamedParamType HybridFg4

hi! link javascriptBrackets HybridFg1
hi! link javascriptDOMElemAttrs HybridFg1
hi! link javascriptDOMEventMethod HybridFg1
hi! link javascriptDOMNodeMethod HybridFg1
hi! link javascriptDOMStorageMethod HybridFg1
hi! link javascriptHeadersMethod HybridFg1

hi! link javascriptAsyncFuncKeyword HybridRed
hi! link javascriptAwaitFuncKeyword HybridRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword HybridAqua
hi! link jsExtendsKeyword HybridAqua
hi! link jsExportDefault HybridAqua
hi! link jsTemplateBraces HybridAqua
hi! link jsGlobalNodeObjects HybridFg1
hi! link jsGlobalObjects HybridFg1
hi! link jsFunction HybridAqua
hi! link jsFuncParens HybridFg3
hi! link jsParens HybridFg3
hi! link jsNull HybridPurple
hi! link jsUndefined HybridPurple
hi! link jsClassDefinition HybridYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved HybridAqua
hi! link typeScriptLabel HybridAqua
hi! link typeScriptFuncKeyword HybridAqua
hi! link typeScriptIdentifier HybridOrange
hi! link typeScriptBraces HybridFg1
hi! link typeScriptEndColons HybridFg1
hi! link typeScriptDOMObjects HybridFg1
hi! link typeScriptAjaxMethods HybridFg1
hi! link typeScriptLogicSymbols HybridFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects HybridFg1
hi! link typeScriptParens HybridFg3
hi! link typeScriptOpSymbols HybridFg3
hi! link typeScriptHtmlElemProperties HybridFg1
hi! link typeScriptNull HybridPurple
hi! link typeScriptInterpolationDelimiter HybridAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword HybridAqua
hi! link purescriptModuleName HybridFg1
hi! link purescriptWhere HybridAqua
hi! link purescriptDelimiter HybridFg4
hi! link purescriptType HybridFg1
hi! link purescriptImportKeyword HybridAqua
hi! link purescriptHidingKeyword HybridAqua
hi! link purescriptAsKeyword HybridAqua
hi! link purescriptStructure HybridAqua
hi! link purescriptOperator HybridBlue

hi! link purescriptTypeVar HybridFg1
hi! link purescriptConstructor HybridFg1
hi! link purescriptFunction HybridFg1
hi! link purescriptConditional HybridOrange
hi! link purescriptBacktick HybridOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp HybridFg3
hi! link coffeeSpecialOp HybridFg3
hi! link coffeeCurly HybridOrange
hi! link coffeeParen HybridFg3
hi! link coffeeBracket HybridOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter HybridGreen
hi! link rubyInterpolationDelimiter HybridAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier HybridRed
hi! link objcDirective HybridBlue

" }}}
" Go: {{{

hi! link goDirective HybridAqua
hi! link goConstants HybridPurple
hi! link goDeclaration HybridRed
hi! link goDeclType HybridBlue
hi! link goBuiltins HybridOrange

" }}}
" Lua: {{{

hi! link luaIn HybridRed
hi! link luaFunction HybridAqua
hi! link luaTable HybridOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp HybridFg3
hi! link moonExtendedOp HybridFg3
hi! link moonFunction HybridFg3
hi! link moonObject HybridYellow

" }}}
" Java: {{{

hi! link javaAnnotation HybridBlue
hi! link javaDocTags HybridAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen HybridFg3
hi! link javaParen1 HybridFg3
hi! link javaParen2 HybridFg3
hi! link javaParen3 HybridFg3
hi! link javaParen4 HybridFg3
hi! link javaParen5 HybridFg3
hi! link javaOperator HybridOrange

hi! link javaVarArg HybridGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter HybridGreen
hi! link elixirInterpolationDelimiter HybridAqua

hi! link elixirModuleDeclaration HybridYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition HybridFg1
hi! link scalaCaseFollowing HybridFg1
hi! link scalaCapitalWord HybridFg1
hi! link scalaTypeExtension HybridFg1

hi! link scalaKeyword HybridRed
hi! link scalaKeywordModifier HybridRed

hi! link scalaSpecial HybridAqua
hi! link scalaOperator HybridFg1

hi! link scalaTypeDeclaration HybridYellow
hi! link scalaTypeTypePostDeclaration HybridYellow

hi! link scalaInstanceDeclaration HybridFg1
hi! link scalaInterpolation HybridAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 HybridGreenBold
hi! link markdownH2 HybridGreenBold
hi! link markdownH3 HybridYellowBold
hi! link markdownH4 HybridYellowBold
hi! link markdownH5 HybridYellow
hi! link markdownH6 HybridYellow

hi! link markdownCode HybridAqua
hi! link markdownCodeBlock HybridAqua
hi! link markdownCodeDelimiter HybridAqua

hi! link markdownBlockquote HybridGray
hi! link markdownListMarker HybridGray
hi! link markdownOrderedListMarker HybridGray
hi! link markdownRule HybridGray
hi! link markdownHeadingRule HybridGray

hi! link markdownUrlDelimiter HybridFg3
hi! link markdownLinkDelimiter HybridFg3
hi! link markdownLinkTextDelimiter HybridFg3

hi! link markdownHeadingDelimiter HybridOrange
hi! link markdownUrl HybridPurple
hi! link markdownUrlTitleDelimiter HybridGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType HybridYellow
" hi! link haskellOperators HybridOrange
" hi! link haskellConditional HybridAqua
" hi! link haskellLet HybridOrange
"
hi! link haskellType HybridFg1
hi! link haskellIdentifier HybridFg1
hi! link haskellSeparator HybridFg1
hi! link haskellDelimiter HybridFg4
hi! link haskellOperators HybridBlue
"
hi! link haskellBacktick HybridOrange
hi! link haskellStatement HybridOrange
hi! link haskellConditional HybridOrange

hi! link haskellLet HybridAqua
hi! link haskellDefault HybridAqua
hi! link haskellWhere HybridAqua
hi! link haskellBottom HybridAqua
hi! link haskellBlockKeywords HybridAqua
hi! link haskellImportKeywords HybridAqua
hi! link haskellDeclKeyword HybridAqua
hi! link haskellDeriving HybridAqua
hi! link haskellAssocType HybridAqua

hi! link haskellNumber HybridPurple
hi! link haskellPragma HybridPurple

hi! link haskellString HybridGreen
hi! link haskellChar HybridGreen

" }}}
" Json: {{{

hi! link jsonKeyword HybridGreen
hi! link jsonQuote HybridGreen
hi! link jsonBraces HybridFg1
hi! link jsonString HybridFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! HybridHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! HybridHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:

