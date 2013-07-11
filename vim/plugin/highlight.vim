function! CopyRTF(options) range
  let command = "!cat % | "
  if a:firstline
    let command = command . "sed -n " . a:firstline . "," . a:lastline . "p | clean_indent | "
  endif
  let command = command . "highlight -O rtf -kInconsolata -K40 --no-trailing-nl --syntax=Ruby --style=fine_blue " . a:options . " | pbcopy"
  exec ":silent :" . command
endfunction

command! -nargs=0 -range CopyRTF <line1>,<line2>call CopyRTF("")
command! -nargs=0 -range CopyRTFWithLines <line1>,<line2>call CopyRTF("--line-numbers --line-number-length=2")
