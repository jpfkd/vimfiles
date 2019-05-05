set columns=96
set lines=36

if has('win32') || has('win64')
  set guifont=Consolas:h13
elseif has('unix')
  set guifont=Inconsolata\ 13
endif

set guioptions+=cp
set guioptions-=T
set guioptions-=m
set nomousehide
set visualbell

nnoremap <X1Mouse> <C-o>
nnoremap <X2Mouse> <C-i>

colorscheme desert
silent! colorscheme gruvbox
