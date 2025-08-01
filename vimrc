" First things first
scriptencoding utf-8
set encoding=utf-8

let $VIMHOMEDIR = $HOME . '/' . (has('unix') ? '.vim' : 'vimfiles')

" Options
set autoindent
set autoread
set backspace=
set clipboard=
set cmdheight=2
set colorcolumn=+2
set complete+=k
set complete-=i
set confirm
set display=lastline
set expandtab
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp932,euc-jp,latin1
set fileformats+=mac
set formatoptions+=nmBj
set helplang=en
set history=10000
set ignorecase
set iminsert=0
set imsearch=-1
set incsearch
set isfname-==
set laststatus=2
set list
set listchars=eol:$,tab:>-,space:.,extends:@,precedes:@,nbsp:+
set makeencoding=default
set matchpairs+=<:>
set matchtime=1
set mouse=a
set nobackup
set nohlsearch
set nojoinspaces
set nolinebreak
set nonumber
set novisualbell
set nrformats-=octal,alpha
set omnifunc=syntaxcomplete#Complete
set pumheight=10
set relativenumber
set scrolloff=5
set sessionoptions+=unix,slash
set shiftround
set shiftwidth=4
set shortmess=a
set showcmd
set showmatch
set sidescroll=1
set signcolumn=yes
set smartcase
set softtabstop=-1
set switchbuf=useopen,usetab
set tagcase=match
set termencoding=default
set textwidth=79
set timeout
set timeoutlen=5000
set ttimeout
set ttimeoutlen=100
set undofile
set undoreload=-1
set updatetime=100
set viminfofile=$VIMHOMEDIR/viminfo
set wildignore+=*.o,*.obj,*.d
set wildmenu
set wildmode=full

if has('langmap')
    set nolangremap
endif

" Settings for statusline (separated for readability)
set statusline=%f
set statusline+=\ [%{&ff}][%{&fenc}%{&bomb?'(BOM)':''}]
set statusline+=%y%h%w%r\ %m
set statusline+=%=
set statusline+=col.%v\ lin.%l/%L

" From archlinux.vim
" Move temporary files to a secure location to protect against CVE-2017-1000382
if exists('$XDG_CACHE_HOME')
    let &directory=$XDG_CACHE_HOME
else
    let &directory=$HOME . '/.cache'
endif
let &undodir=&directory . '/vim/undo//'
let &backupdir=&directory . '/vim/backup//'
let &directory.='/vim/swap//'
" Create directories if they doesn't exist
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), 'p', 0700)
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p', 0700)
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p', 0700)
endif

" Mappings
nnoremap Y y$

noremap Q gq
noremap gQ gq

noremap <C-H> ^
noremap <C-L> $
noremap <C-K> {
noremap <C-J> }

vnoremap S :sort<CR>

" Mappings for QuickFix/Location List.
nnoremap <F2> :<C-U>cwindow<CR>
nnoremap <F3> :<C-U>lwindow<CR>

nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprevious<CR>

" Mappings for make. Maybe these should be filetype specific?
nnoremap <F4> :<C-U>make clean<CR>
nnoremap <F5> :<C-U>make debug<CR>
nnoremap <F6> :<C-U>make<CR>
nnoremap <F7> :<C-U>make %:r:S<CR>
nnoremap <F8> :<C-U>make %:r:S.o<CR>

" From defaults.vim
" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" bash-like navigation in command line
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-D> <Del>

" Abbreviations (for spell correction)
noreabbrev teh the
noreabbrev ofr for
noreabbrev cosnt const
noreabbrev maek make
noreabbrev amke make

" Auto commands
augroup vimrc
    autocmd!
    au QuickFixCmdPost * cwindow

    au FileType vim,help setl keywordprg=:help

    au FileType php nnoremap <buffer> <F7> :<C-u>!php %<CR>

    au FileType cs nnoremap <buffer> <F7> :<C-u>!dotnet run<CR>

    " From defaults.vim, modified not to change jumplist.
    " When editing a file, always jump to the last known cursor position. Don't
    " do it when the position is invalid, when inside an event handler (happens
    " when dropping a file on gvim) and for a commit message (it's likely a
    " different one than last time).
    au BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g'\""
                \ | endif
augroup END

" Plugin settings

" plugins included in vim runtime
if !has('nvim')
    packadd! matchit
    packadd! termdebug
endif

" netrw settings
let g:netrw_liststyle = 1
let g:netrw_sizestyle = "H"
let g:netrw_timefmt="%Y/%m/%d %H:%M:%S"

" minpac settings
packadd minpac
function s:LoadMinpac() abort
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Plugins are listed in separate file so you don't have to reload vimrc after
    " editing the plugin list
    runtime minpac_list.vim
endfunction

command! MinpacUpdate call s:LoadMinpac()
            \ | call minpac#update('', {'do': {-> minpac#status({'open': 'horizontal'})}})
command! MinpacClean  call s:LoadMinpac() | call minpac#clean()

nnoremap <F12> :<C-U>MinpacUpdate<CR>

" vim-autoformat settings
let g:autoformat_autoindent = 0
noremap <F9> :Autoformat<CR>

" sort-words settings
vmap gs <Plug>(SortWords)

" auto-pair settings
let g:AutoPairsCenterLine = 0

" easy-align settings
vmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" vim-man setttings
if executable('man') == 1
    set keywordprg=:Man
endif

" ALE settings
let g:ale_echo_msg_format = '%code: %%s - %linter%'
let g:ale_set_highlights = 0

let g:ale_c_parse_makefile = 1

" vim-sandwich settings
packadd vim-sandwich
call operator#sandwich#set('all', 'all', 'highlight', 0)

" switch settings
packadd switch.vim
let g:switch_custom_definitions = [
            \   switch#NormalizedCase(['true', 'false']),
            \   switch#NormalizedCase(['on', 'off']),
            \   switch#NormalizedCase(['enable', 'disable']),
            \ ]

" Colorscheme
if &t_Co >= 256
    set background=dark
    colorscheme gruvbox8
endif

" These should be the last
filetype plugin indent on
syntax enable
set secure
