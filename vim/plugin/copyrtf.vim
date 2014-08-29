function! CopyRTF() range
  let command = "!cat % | "
  if a:firstline
    let command = command . "sed -n " . a:firstline . "," . a:lastline . "p | clean_indent | "
  endif
  let command = command . "pygmentize -f rtf '-Pfontface=Inconsolata' -l " . &filetype . " | pbcopy"
  exec ":silent :" . command
  redraw!
endfunction

command! -nargs=0 -range CopyRTF <line1>,<line2>call CopyRTF()
