" flog wrappers
function! FlogFile()
  let current = fnamemodify(expand("%"), ':p')
  call FlogAnalyze(current)
endfunction

function! FlogAll()
  if executable('app')
    call FlogAnalyze('app lib -g')
  else
    call FlogAnalyze('lib -g')
  end
endfunction

function! FlogAnalyze( path )
  exec ":silent :!flog " . a:path . " | " . " awk '" . "length($1) > 4 && match($3, /[0-9\.]+/) {printf( \"\\%s:\\%s - flog score - \\%s \\n\", $3, $2,$1)}'  > ~/.flog-results"
  exec ':cfile ~/.flog-results'
endfunction

" matches the output above
set errorformat+=%f:%l:%m

command! -nargs=0 Flog call FlogAll()
