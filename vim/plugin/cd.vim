function! Cd(path)
  execute "cd " . a:path
  edit .
endfunction

function! CompleteDirInCdPath(ArgLead, CmdLine, CursorPos)
  let paths = split(globpath(&cdpath, '*'), '\n')
  let result = []
  for path in paths
    if isdirectory(path)
      let result += [fnamemodify(path, ':t')]
    endif
  endfor
  return join(result, "\n")
endfunction

command! -nargs=1 -complete=custom,CompleteDirInCdPath Cd call Cd(<q-args>)
cabbr cd Cd
