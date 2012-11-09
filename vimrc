" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use The Silver Searcher instead of Grep when available
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Color scheme
colorscheme custom

" Numbers
if v:version > 702
	set relativenumber
	set numberwidth=4
else
	set number
	set numberwidth=5
endif

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
imap <Tab> <C-P>
set complete=.,w,t,b

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" No Help, please
nmap <F1> <Esc>

" Window navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Start git commit messages in insert mode
au FileType gitcommit execute "normal" "gg"
au FileType gitcommit startinsert

" Help keep lines within 80 columns
set colorcolumn=80

" Open the quickfix window after running grep
autocmd QuickFixCmdPost *grep* cwindow

" Search for the word under the cursor
" Normal mode: K
nmap K :grep "\b<C-R><C-W>\b"<CR>

" Replace double quotes with single quotes
nmap <Leader>' :s/"/'/g<CR>

" Markdown files end in .md
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.md set spell

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
