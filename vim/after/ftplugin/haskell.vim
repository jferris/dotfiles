setl autoindent
setl shiftwidth=4
setl include=^import\\s*\\(qualified\\)\\?\\s*
setl includeexpr=substitute(v:fname,'\\.','/','g').'.'
setl suffixesadd=hs,lhs,hsc

function! Hoogle(function)
  call system("chromium \"https://www.fpcomplete.com/hoogle?q=" . a:function . "&env=ghc-7.4.2-stable-13.09\"")
endfunction

" Search for the current word using Hoogle
nmap <buffer> <Leader>K :call Hoogle("<C-R><C-W>")<CR>

" Compile with cabal
let s:cabalFilePresent = filereadable(glob('*.cabal'))
if s:cabalFilePresent
  setl makeprg=cabal\ build
else
  let s:currentFile = expand('%')
  if !exists('b:qfOutputdir')
    let b:qfOutputdir = tempname()
    call mkdir(b:qfOutputdir)
  endif
  let &l:makeprg = 'ghc --make % -outputdir ' . b:qfOutputdir
endif

setl errorformat=
  \%-Z\ %#,
  \%W%f:%l:%c:\ Warning:\ %m,
  \%E%f:%l:%c:\ %m,
  \%E%>%f:%l:%c:,
  \%+C\ \ %#%m,
  \%W%>%f:%l:%c:,
  \%+C\ \ %#%tarning:\ %m,

Snippet :: <{name}> :: <{}><CR><{name}> = undefined
