" -----------------------------------------------------------------------------
" File: hybrid-redux.vim
" Description: Hybrid originally created by https://github.com/w0ng. Vimscript
" from gruvbox: https://github.com/morhetz/gruvbox
" Author: micke <hi@micke.me>
" Source: https://github.com/lisinge/vim-hybrid-redux
" Based On: https://github.com/w0ng/vim-hybrid and https://github.com/morhetz/gruvbox
" License: MIT
" -----------------------------------------------------------------------------

function! hybrid#invert_signs_toggle()
  if g:hybrid_invert_signs == 0
    let g:hybrid_invert_signs=1
  else
    let g:hybrid_invert_signs=0
  endif

  colorscheme hybrid
endfunction

" Search Highlighting {{{

function! hybrid#hls_show()
  set hlsearch
  call HybridHlsShowCursor()
endfunction

function! hybrid#hls_hide()
  set nohlsearch
  call HybridHlsHideCursor()
endfunction

function! hybrid#hls_toggle()
  if &hlsearch
    call hybrid#hls_hide()
  else
    call hybrid#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
