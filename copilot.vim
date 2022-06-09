" MIT License. Copyright (c) 2022 Jaskaran Veer Singh
" Plugin: https://github.com/jvsg/copilot.vim
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

let s:spc = g:airline_symbols.space
let emoji_working1 = "[|]"
let emoji_working2 = "[-]"

if !exists("g:loaded_copilot")
  finish
endif

function! airline#extensions#copilot#check(...) abort
    let logfile = copilot#logger#File()
    let requestnumber = system("tail " . logfile . "| grep -n 'fetchCompletions' | cut -d':' -f1 | tail -1")
    let responsenumber = system("tail " . logfile . "| grep -n 'request.response' | cut -d':' -f1 | tail -1")
    echo "Copilot: " . requestnumber . " requests, " . responsenumber . " responses"
endfunction

function! airline#extensions#copilot#init(ext) abort
    call airline#parts#define_function('copilot', 'airline#extensions#copilot#check')
endfunction

