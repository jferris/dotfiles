function! GitUnmerged(args)
  let unmerged = system("git-unmerged-next")
  if unmerged == ''
    echo "No unmerged files remaining"
  else
    execute "edit " . unmerged
  endif
endfunction

function! GitResolve(args)
  execute "silent !git add %"
  write
  call GitUnmerged()
endfunction

command! -nargs=0 GitUnmerged call GitUnmerged(<q-args>)
command! -nargs=0 GitResolve call GitResolve(<q-args>)
