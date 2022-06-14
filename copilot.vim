" MIT License. Copyright (c) 2022 Jaskaran Veer Singh
" Plugin: https://github.com/jvsg/copilot.vim
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

if !exists("g:loaded_copilot")
  finish
endif

" truncate the newline char
function! System(cmd)
  return system(a:cmd)[:-2]
endfunction

let g:emoji_working1 = "Copilot"
let g:emoji_working2 = "[-]"

let g:copilot_check_interval = 1
let g:copilot_last_check = 0

function! airline#extensions#copilot#check(...) abort
  let time = str2nr(localtime())
  if time > g:copilot_last_check + g:copilot_check_interval
    let g:copilot_last_check = time
    let logfile = copilot#logger#File()
    let requestnumber = System("tail " . logfile . "| grep -n 'fetchCompletions' | cut -d':' -f1 | tail -1")
    let responsenumber = System("tail " . logfile . "| grep -n 'request.response' | cut -d':' -f1 | tail -1")
    if str2nr(requestnumber) > str2nr(responsenumber)
      return g:emoji_working2
    else
      return g:emoji_working1
    endif
  endif
endfunction

function! airline#extensions#copilot#init(ext) abort
    call airline#parts#define_function('copilot', 'airline#extensions#copilot#check')
endfunction

