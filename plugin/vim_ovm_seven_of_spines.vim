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
  call s:InhibitCompletionMenu()

  return "\<home>i-------\n\n\<end>"
endfunction

function! s:WriteSevenDashesNlNl_I()
  call s:InhibitCompletionMenu()

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

" HSTRY/2025-03-05: Hide completion if it pops up after the maps insert text.
"
" - Ideally, we'd inhibit the completion menu from popping up
"   in the first place, but this is the only approach that I
"   got to work.
"
"   - LOPRI: Using a timer feels hacky. Find a better way.
"
" - Currently just supports blink.cmp
"
" - SAVVY: Using a 0 timeout it too fast. Same with 10, 33, 50.
"   - 100 timeout works, but it's noticable, a quick blip!
"   - 66 also works, also sometimes blips, but not as bad.
"     And sometimes you don't see the completion menu at
"     all... (ugh, such a terrible solution, ha).
"
"   - Adding trailing "\<c-e>" to return string doesn't help,
"     even though <C-e> mapped to hide completion.
"
"   - Nor does toggling it off before the insert, then on
"     again after a timeout work:
"
"       let g:blink_cmp_enabled = 0
"       call timer_start(200, { -> execute('let g:blink_cmp_enabled = 1', '')})

function! s:InhibitCompletionMenu() abort
  call timer_start(66, { -> execute('lua pcall(function() require("blink-cmp").hide() end)', '')})
endfunction

" -------------------------------------------------------------------

call <SID>ResetBindingsSevenOfSpines()

