" Insert seven dashes and two newlines when you press <Shift-Ctrl-Dash>
" Author: Landon Bouma <https://tallybark.com/>
" Online: https://github.com/landonb/vim-ovm-seven-of-spines
" License: https://creativecommons.org/publicdomain/zero/1.0/
"  vim:tw=0:ts=2:sw=2:et:norl:ft=vim
" Copyright © 2020 Landon Bouma.

" ########################################################################

" DEV: Uncomment the 'unlet', then <F9> to reload this file.
"       https://github.com/landonb/vim-source-reloader
"  silent! unlet g:loaded_ovm_seven_of_spines

if exists("g:loaded_ovm_seven_of_spines") || &cp
  finish
endif
let g:loaded_ovm_seven_of_spines = 1

" ########################################################################

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

" ########################################################################

function! s:WriteSevenDashesNlNl_N()
  return "\<home>i-------\n\n\<end>"
endfunction

function! s:WriteSevenDashesNlNl_I()
  return "\<home>-------\n\n\<end>"
endfunction

" ########################################################################

function! s:ClearBindingsSevenOfSpines()
  silent! nunmap <C-_>
  silent! iunmap <buffer><expr> <C-_>
endfunction

function! s:SetupBindingsSevenOfSpines()
  nnoremap <expr> <C-_> <SID>WriteSevenDashesNlNl_N()
  inoremap <expr> <C-_> <SID>WriteSevenDashesNlNl_I()
endfunction

function! s:ResetBindingsSevenOfSpines()
  call <SID>ClearBindingsSevenOfSpines()
  call <SID>SetupBindingsSevenOfSpines()
endfunction

" ########################################################################

call <SID>ResetBindingsSevenOfSpines()

" ########################################################################

