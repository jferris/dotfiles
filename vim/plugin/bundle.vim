function! BundleOpen(gem)
  execute "!bundle show " . a:gem . " | pbcopy"
  let path = system("pbpaste")
  execute "Explore " . strpart(path, 0, strlen(path) - 1)
endfunction

command! -nargs=1 BundleOpen call BundleOpen(<q-args>)
