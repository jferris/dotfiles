function! ReloadChrome()
  wall
  execute ":silent !reload-chrome"
endfunction

nmap <Leader>rl :call ReloadChrome()<CR>
