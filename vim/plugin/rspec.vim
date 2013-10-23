let g:test_path_prefix = "."

function! RunSpec(args)
  if IsTestUnit()
    let s:last_spec_command = "ruby -Itest " . a:args
  else
    let s:last_spec_command = "rspec " . a:args
  end
  call RunInTerminal(s:last_spec_command)
endfunction

function! PathToSpec()
  let path = expand("%")
  if stridx(path, "/") == 0 || stridx(path, "~") == 0
    return path
  else
    return g:test_path_prefix . "/" . path
  endif
endfunction

function! RunAllSpecs()
  call RunSpec(PathToSpec())
endfunction

function! RunSpecAtLine(line)
  if IsTestUnit()
    call RunSpec(PathToSpec() . " " . "-n \"/" . TestNameAtLine(a:line) . "/\"")
  else
    call RunSpec("-l " . a:line . " " . PathToSpec())
  end
endfunction

function! TestNameAtLine(lineNumber)
  let line = getline(a:lineNumber)
  let name = substitute(line, "^\\s\\+test [\"']", "", "")
  let name = substitute(name, "[\"'] do$", "", "")
  let name = substitute(name, " ", "_", "g")
  let name = substitute(name, "[()]", ".", "g")
  return name
endfunction

function! IsTestUnit()
  return stridx(expand("%"), "_test.rb") > 0
endfunction

function! RerunSpec()
  call RunInTerminal(s:last_spec_command)
endfunction

function! RunInTerminal(command)
  execute ":silent !run-in-terminal '" . a:command . "'"
endfunction

nmap <Leader>tl :call RunSpecAtLine(<C-r>=line('.')<CR>)<CR>
nmap <Leader>ta :call RunAllSpecs()<CR>
nmap <Leader>tb ?context\\|describe<CR><Leader>tl''
nmap <Leader>tr :call RerunSpec()<CR>

command! -nargs=* -complete=file RunSpec call RunSpec(<q-args>)
