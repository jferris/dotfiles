function! GitUnmerged()
  let unmerged = system("git-unmerged-next")
  if unmerged == ''
    echo "No unmerged files remaining"
  else
    execute "edit " . unmerged
  endif
endfunction

function! GitResolve()
  write
  execute "silent !git add %"
  call GitUnmerged()
endfunction

command! -nargs=0 GitUnmerged call GitUnmerged()
command! -nargs=0 GitResolve call GitResolve()
