" Filters search history and finds selected item.
"
if exists('g:loaded_ctrlp_history_search') && g:loaded_ctrlp_history_search
  finish
endif
let g:loaded_ctrlp_history_search = 1

let s:history_search_var = {
            \ 'init': 'ctrlp#history#search#init()',
            \ 'exit': 'ctrlp#history#search#exit()',
            \ 'accept': 'ctrlp#history#search#accept',
            \ 'lname': 'history_search',
            \ 'sname': 'history_search',
            \ 'type': 'history_search',
            \ 'sort': 0,
            \}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
    let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:history_search_var)
else
    let g:ctrlp_ext_vars = [s:history_search_var]
endif

function! ctrlp#history#search#init()
    redir => hist
    silent history /
    redir END
    let arranged_hist = []
    for h in split(hist,"\n")[1:]
        call add(arranged_hist,matchlist(h,'\s*\d\+\s*\(.*\)')[1])
    endfor
    return reverse(arranged_hist)
endfunc

function! ctrlp#history#search#accept(mode, str)
    call ctrlp#exit()
    echo a:str
    let @/ = a:str
    try
        normal! n
    catch /^Vim\%((\a\+)\)\=:E486/
        "pattern not found
    endtry
endfunction

function! ctrlp#history#search#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#history#search#id()
    return s:id
endfunction
