" Insert seven dashes and two newlines when you press <Shift-Ctrl-Dash>
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/landonb/vim-ovm-seven-of-spines#🦴
" License: https://creativecommons.org/publicdomain/zero/1.0/
"  vim:tw=0:ts=2:sw=2:et:norl:ft=vim
" Copyright © 2020 Landon Bouma.

" -------------------------------------------------------------------

" GUARD: Press <F9> to reload this plugin (or :source it).
" - Via: https://github.com/embrace-vim/vim-source-reloader#↩️

if expand('%:p') ==# expand('<sfile>:p')
  unlet! g:loaded_ovm_seven_of_spines
endif

if exists('g:loaded_ovm_seven_of_spines') || &cp

  finish
endif

let g:loaded_ovm_seven_of_spines = 1

" -------------------------------------------------------------------

" This plugin uses a map expression <expr> to insert seven dashes and two
" newlines when you press <Ctrl-Shift-Dash>, aka <C-S-->, aka <C-_>.
"
" - The code below uses a little trick to move the cursor.
"
"   Per the help,
"
"     https://vimhelp.org/map.txt.html#:map-expression
"
"   one is not allowed to move the cursor in an <expr>
"   expression insert mode mapping with the normal motion
"   commands. But you can fake it with motion *keypresses*
"   in the inserted text, e.g., <Home> and <End>.

" -------------------------------------------------------------------

function! s:WriteSevenDashesNlNl_N()
  return "\<home>i-------\n\n\<end>"
endfunction

function! s:WriteSevenDashesNlNl_I()
  return "\<home>-------\n\n\<end>"
endfunction

" -------------------------------------------------------------------

function! s:ClearBindingsSevenOfSpines()
  if has('nvim')
    silent! nunmap <C-->
    silent! iunmap <buffer><expr> <C-->
  else
    silent! nunmap <C-_>
    silent! iunmap <buffer><expr> <C-_>
  endif
endfunction

function! s:SetupBindingsSevenOfSpines()
  if has('nvim')
    nnoremap <expr> <C--> <SID>WriteSevenDashesNlNl_N()
    inoremap <expr> <C--> <SID>WriteSevenDashesNlNl_I()
  else
    nnoremap <expr> <C-_> <SID>WriteSevenDashesNlNl_N()
    inoremap <expr> <C-_> <SID>WriteSevenDashesNlNl_I()
  endif
endfunction

function! s:ResetBindingsSevenOfSpines()
  call <SID>ClearBindingsSevenOfSpines()
  call <SID>SetupBindingsSevenOfSpines()
endfunction

" -------------------------------------------------------------------

call <SID>ResetBindingsSevenOfSpines()

