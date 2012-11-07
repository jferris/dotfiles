function! Rspec(args)
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

nmap <Leader>tl :call Rspec("-l " . <C-r>=line('.')<CR>)<CR>
nmap <Leader>ta :call Rspec("")<CR>
nmap <Leader>tb ?context\\|describe<CR><Leader>tl''
nmap <Leader>tr :call RerunSpec()<CR>

command! -nargs=* -complete=file Rspec call Rspec(<q-args>)
