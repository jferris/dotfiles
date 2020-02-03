setl autoindent
setl shiftwidth=4
setl include=^import\\s*\\(qualified\\)\\?\\s*
setl includeexpr=substitute(v:fname,'\\.','/','g').'.'
setl suffixesadd=hs,lhs,hsc
setl path=src

function! Hoogle(function)
  call system("chromium \"https://www.fpcomplete.com/hoogle?q=" . a:function . "&env=ghc-7.4.2-stable-13.09\"")
endfunction

function! CheckTest()
  cclose
  update
  GhcModCheck
  if empty(getqflist())
    Start stack test
  endif
endfunction

" Search for the current word using Hoogle
nmap <buffer> <Leader>K :call Hoogle("<C-R><C-W>")<CR>

" Run tests
nmap <buffer> <Leader>t :call CheckTest()<CR>

" Compile with cabal
let s:cabalFilePresent = filereadable(glob('*.cabal'))
let s:stackFilePresent = filereadable('stack.yaml')
if s:stackFilePresent
  setl makeprg=stack\ build

  " Load in Stack repl
  nmap <buffer> <Leader>i :Start stack ghci --ghci-options %<CR>
elseif s:cabalFilePresent
  setl makeprg=cabal\ build

  " Load in Cabal repl
  nmap <buffer> <Leader>i :Start cabal exec -- ghci %<CR>
else
  " Load in GHCI
  nmap <buffer> <Leader>i :Start ghci %<CR>

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

highlight hsundefined ctermbg=red guibg=red
call matchadd("hsundefined", "undefined")

nmap <buffer> <Leader>? :update<CR>:GhcModType<CR>
nmap <buffer> <Leader>_ :update<CR>:GhcModTypeInsert<CR>
nmap <buffer> <Leader>= :update<CR>:GhcModSigCodegen<CR>
