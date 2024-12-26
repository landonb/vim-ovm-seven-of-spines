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
  unlet! g:loaded_ovm_twenty_one_sevenwich
endif

if exists('g:loaded_ovm_twenty_one_sevenwich') || &cp

  finish
endif

let g:loaded_ovm_twenty_one_sevenwich = 1

" -------------------------------------------------------------------

function! s:Write7217Splitter_N()
  return "\<home>i-------\n\n─────────────────────\n\n-------\n\n\<end>"
endfunction

function! s:Write7217Splitter_I()
  return "\<home>-------\n\n─────────────────────\n\n-------\n\n\<end>"
endfunction

" -------------------------------------------------------------------

" I tried <C-+>... no bananas.

function! s:ClearBindings7217Splitter()
  silent! nunmap <M-_>
  silent! iunmap <buffer><expr> <M-_>
endfunction

function! s:SetupBindings7217Splitter()
  nnoremap <expr> <M-_> <SID>Write7217Splitter_N()
  inoremap <expr> <M-_> <SID>Write7217Splitter_I()
endfunction

function! s:ResetBindings7217Splitter()
  call <SID>ClearBindings7217Splitter()
  call <SID>SetupBindings7217Splitter()
endfunction

" -------------------------------------------------------------------

call <SID>ResetBindings7217Splitter()

