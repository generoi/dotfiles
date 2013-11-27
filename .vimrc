" Make Vim more useful
set nocompatible
" Enhance command-line completion
set wildmenu
" Turn on wild mode huge list
set wildmode=list:longest
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Automatically change directory to where you are working
set autochdir
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Change buffers without saving
set hidden
" Keep a longer history
set history=1000
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" If there are caps, go case-sensitive
set smartcase
" automatically insert comment leader on return and let gq format commets
set formatoptions+=rq
" Do not wrap lines
set nowrap
" Round indent to multiple of shiftwidth
set shiftround
" Allow moving to unexisting lines/spaces in visual block mode
set virtualedit=block
" Move to previous line when no more characters
set whichwrap+=<,>,h,l,[,]
" Open all folds by default
set foldlevelstart=99
" What movements open folds
set foldopen=hor,mark,percent,quickfix,tag

" Space to toggle folds
nnoremap <space> zA
vnoremap <space> zA

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to focus the current fold
nnoremap <leader>z zMzAzz

" Create directories if they dont exist
if !isdirectory($HOME . '/.vim/swap')
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
if !isdirectory($HOME . '/.vim/undo')
  :silent !mkdir -p ~/.vim/undo >/dev/null 2>&1
endif
if !isdirectory($HOME . '/.vim/backup')
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif

if exists("+undofile")
  set undodir=~/.vim/undo//
  set undofile
  set undolevels=1000
  set undoreload=10000
endif
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess+=filmnrxoOtT
" Dinstinguish wrapped lines
set showbreak=↪
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Toggle paste mode
set pastetoggle=<F2>
colorscheme slate

" Resize splits when the window is resize
au VimResized * exe "normal! \<c-w>="
"
" Move by file line not screen line
nnoremap j gj
nnoremap k gk

" Window movement
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Make backspace delete in visual mode
vnoremap <bs> x
" Display marks
nnoremap <leader>ma :marks<CR>
" Close current buffer
noremap qq :bd<CR>
" Save a file as root
cnoremap w!! :w !sudo tee % > /dev/null<CR>
" Reselect text that was just pasted
nnoremap <leader>v V`]
" Toggle invisible characters
nnoremap <leader>ii :set list!<CR>
" Visual shifting without exiting visual mode
vnoremap < <gv
vnoremap > >gv
" Perl style regular expressions by default
nnoremap / /\v
vnoremap / /\v
" Clear search
nnoremap <leader><space> :noh<cr>

" ` is difficult to press on a swedish keyboard
noremap '. `.
noremap '< `<
noremap '> '>
noremap '[ `[
noremap '] ']

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Allow using the repeat operator with a visual selection (!)
vnoremap . :normal .<CR>

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

" Generate a doxygen comment for implement hooks {{{
noremap <leader>di :call DrupalImplementsComment ()<CR>

function! DrupalImplementsComment ()
  let module = matchstr(bufname("%"), '[a-z0-9]*')
  let current_line = getline(".")
  let hook_idx = matchend(current_line, "function " . module . "_")
  if !empty(module) && hook_idx != -1
    let hook_length = match(current_line, "(") - hook_idx
    let hook_name = strpart(current_line, hook_idx, hook_length)
    call DoxygenComment ("Implements hook_" . hook_name . "().")
  else
    call DoxygenComment ()
  endif
endfunction " }}}
" Doxygen comment {{{
" if a message is passed the cursor will remain
" put, if not, vim will be in insert mode ready for comment message.
noremap <leader>dc :call DoxygenComment ()<CR>

function! DoxygenComment (...)
  set paste
  let message = (a:0 > 0) ? a:1 : ''
  exe "normal! O/**\<CR>"
    \ . " * " . message . "\<CR>"
    \ . " */\<Esc>"
  if empty(message)
    -1 | startinsert!
  else
    +1
  endif
  set nopaste
endfunction " }}}
" CSS {{{

augroup ft_css
  au!

  au FileType less,css,sass,scss setlocal foldmethod=marker
  "au FileType less,css,sass setlocal foldmarker={,}
  au Filetype less,css,sass,scss setlocal omnifunc=csscomplete#CompleteCSS
  au Filetype less,css,sass,scss setlocal iskeyword+=-

  "Sort CSS attributes alphabetically
  au BufNewFile,BufRead *.less,*.css,*.sass,*.scss nnoremap <buffer> <leader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

  " Autocomplete {<cr> properly
  au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><esc>O
augroup END

" }}}
" HTML {{{

augroup ft_html
  au!
  au FileType html setlocal foldmethod=manual
  au Filetype html setlocal omnifunc=htmlcomplete#CompleteTags
augroup END

" }}}
" JavaScript {{{

augroup ft_javascript
  au!

  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}

  " Autocopmlete {<cr> properly
  au BufNewFile,BufRead *.js inoremap <buffer> {<cr> {}<left><cr><esc>O
augroup END

" }}}
" PHP {{{

" Set Wordpres specific settings according to code conventions
function! SetWPConfig ()
  setlocal shiftwidth=2 softtabstop=2 tabstop=2
  setlocal noexpandtab
  setlocal nolist
endfunction

" Set Drupal specific settings according to code conventions
function! SetDrupalConfig ()
  if &filetype == 'php'
    setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
    setlocal listchars=tab:▸\ ,trail:·
  endif
endfunction

augroup ft_php
  au!

  au FileType php setlocal foldmethod=marker
  au FileType php setlocal foldmarker={,}

  au BufRead,BufNewFile *.module,*.install,*.test,*.inc setlocal filetype=php

  " Wordpress and Drupal files
  au BufRead,BufNewFile */wp-content/* call SetWPConfig()
  au BufRead,BufNewFile */sites/all/* call SetDrupalConfig()
augroup END

" }}}
" Markdown {{{

augroup ft_markdown
  au!

  au BufNewFile,BufRead *.m*down setlocal filetype=markdown
  au Filetype markdown setlocal omnifunc=htmlcomplete#CompleteTags

  " Use <localleader>1/2/3 to add headings.
  au Filetype markdown nnoremap <buffer> <leader>1 yypVr=
  au Filetype markdown nnoremap <buffer> <leader>2 yypVr-
  au Filetype markdown nnoremap <buffer> <leader>3 I### <ESC>
augroup END

" }}}
" Vim {{{

augroup ft_vim
  au!

  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}
" QuickFix {{{

augroup ft_quickfix
  au!

  au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0
augroup END

" }}}
