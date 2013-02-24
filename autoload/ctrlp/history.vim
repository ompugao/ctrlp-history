if exists('g:loaded_ctrlp_history') && g:loaded_ctrlp_history
  finish
endif
let g:loaded_ctrlp_history = 1

let s:history_var = {
            \ 'init': 'ctrlp#history#init()',
            \ 'exit': 'ctrlp#history#exit()',
            \ 'accept': 'ctrlp#history#accept',
            \ 'lname': 'history',
            \ 'sname': 'history',
            \ 'type': 'history',
            \ 'sort': 0,
            \}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
    let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:history_var)
else
    let g:ctrlp_ext_vars = [s:history_var]
endif

function! ctrlp#history#init()
    redir => hist
    silent history
    redir END
    let arranged_hist = []
    for h in split(hist,"\n")[1:]
        call add(arranged_hist,matchlist(h,'\s*\d\+\s*\(.*\)')[1])
    endfor
    return reverse(arranged_hist)
endfunc

function! ctrlp#history#accept(mode, str)
    call ctrlp#exit()
    echo a:str
    exec a:str
endfunction

function! ctrlp#history#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#history#id()
    return s:id
endfunction
