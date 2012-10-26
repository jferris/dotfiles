function! PutReplaceMotion(type)
  if a:type == 'line'
    silent execute "normal! `[V`]"
  else
    silent execute "normal! `[v`]"
  end
  silent execute "normal! p"
endfunction

nmap <silent> R :set opfunc=PutReplaceMotion<CR>g@
