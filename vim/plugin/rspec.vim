function! RunSpec(args)
  let spec = expand("%")
  let s:last_spec_command = "rspec -fd " . a:args . " " . spec
  call RunInTerminal(s:last_spec_command)
endfunction

function! RerunSpec()
  call RunInTerminal(s:last_spec_command)
endfunction

function! RunInTerminal(command)
  wall
  execute ":silent !run-in-terminal '" . a:command . "'"
endfunction

nmap <Leader>tl :call RunSpec("-l " . <C-r>=line('.')<CR>)<CR>
nmap <Leader>ta :call RunSpec("")<CR>
nmap <Leader>tb ?context\\|describe<CR><Leader>tl''
nmap <Leader>tr :call RerunSpec()<CR>

command! -nargs=* -complete=file RunSpec call RunSpec(<q-args>)
