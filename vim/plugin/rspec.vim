function! RunSpec(args)
  if IsTestUnit()
    let s:last_spec_command = "ruby -Itest " . a:args
  else
    let s:last_spec_command = "rspec " . a:args
  end
  call RunInTerminal(s:last_spec_command)
endfunction

function! RunAllSpecs()
  call RunSpec(expand("%"))
endfunction

function! RunSpecAtLine(line)
  let spec = expand("%")
  if IsTestUnit()
    call RunSpec(spec . " " . "-n \"/" . TestNameAtLine(a:line) . "/\"")
  else
    call RunSpec("-l " . a:line . " " . spec)
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
