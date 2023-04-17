syntax on

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" set ai            " always set autoindenting on
" set backup        " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
            " than 50 lines of registers
set history=50        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set wildmenu        " display completion matches in a status line

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  " 1724126 - do not open new file with .spec suffix with spec file template
  " apparently there are other file types with .spec suffix, so disable the
  " template
  " autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

filetype plugin on

"if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
"  set nolangremap
"endif



let c_comment_strings=1

set splitright
set splitbelow

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

nnoremap <F2> :DiffOrig<CR>za

" set leader key to spacebar
let mapleader = " "

" relative line numbers
set nu
set rnu

" search options ('/' and '?')
set hlsearch
set incsearch
set nohlsearch
set ignorecase
set smartcase

" block cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" max number of tabs
set tabpagemax=100

" chad mode enabled
noremap <up> <nop>
noremap <left> <nop>
noremap <down> <nop>
noremap <right> <nop>


" back to file explorer
nnoremap <leader>pv :Explore<CR>

" disable K and Q (both evil)
noremap K <nop>
noremap Q <nop>

" J at the beginning of the line
noremap J mjJ'j

" move lines when in visual mode
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" Perl substitution
noremap S :perldo s//g<left><left>

" capital y with d-like behavior
map Y y$

" yank to system clipboard
noremap <leader>y "+y
nnoremap <leader>Y "+Y

" change to void
noremap <leader>c "_c
nnoremap <leader>C "_C

" delete to void
noremap <leader>d "_d
nnoremap <leader>D "_D

" greatest remap ever
vnoremap <leader>p "_dP

" scroll and center
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

" seach and center cursor
noremap n nzz
noremap N Nzz

" make current file executable
nnoremap <silent> <leader>x :!chmod +x %<CR><CR>

" move between buffers
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" move buffers
nnoremap <leader>j <C-W>J
nnoremap <leader>k <C-W>K
nnoremap <leader>l <C-W>L
nnoremap <leader>h <C-W>H

" terminal normal mode
tnoremap <C-N> <C-W>N

" CRLF to LF
noremap <F4> :e ++ff=unix<CR>:perldo s/\r//g<CR>

" delete trailing white space
command! Trim :perldo s/\s+$//gm
noremap <F5> :Trim<CR>

" convert tabs to spaces (needs some fixing)
command! TabsToSpaces :perldo s/\t/    /gm
noremap <F6> :TabsToSpaces<CR>

" vertical guideline
set colorcolumn=100

" tab size
" filetype plugin indent on
" set expandtab
set tabstop=4
set shiftwidth=4

autocmd FileType xml  setlocal shiftwidth=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType pug  setlocal shiftwidth=2 softtabstop=2


" toggle wrap
noremap <F8> :set wrap!<CR>

" move tabs
noremap <F9>  :tabm -1<CR>
noremap <F10> :tabm +1<CR>

" new tab
nnoremap <leader>tn :tabnew<CR>

" new vsplit
nnoremap <leader>vn :vert new<CR>

" new vsplit
nnoremap <leader>w :w<CR>


" source fzf
source /usr/share/vim/vimfiles/plugin/fzf.vim

" -- fzf options
" all files
nnoremap <leader>ff :call fzf#run(fzf#wrap({'options': ['--prompt', getcwd()]}))<CR>'

" files tracked by git only
nnoremap <leader>fg :call fzf#run(
    \fzf#wrap({'source': 'git ls-files', 'options': ['--prompt', getcwd()]}))<CR>'

" same thing, but open in a new tab
" nnoremap <leader>tf :call fzf#run(
"    \fzf#wrap({'sink': 'tabe', 'options': ['--prompt', getcwd()]}))<CR>'

" nnoremap <leader>tg :call fzf#run(
"    \fzf#wrap({'source': 'git ls-files', 'sink': 'tabe', 'options': ['--prompt', getcwd()]}))<CR>'

" same thing, but open in a vertical split
" nnoremap <leader>vf :call fzf#run(
"    \fzf#wrap({'sink': 'vert new', 'options': ['--prompt', getcwd()]}))<CR>'

" nnoremap <leader>vg :call fzf#run(
"    \fzf#wrap(
"        \{'source': 'git ls-files', 'sink': 'vert new', 'options': ['--prompt', getcwd()]}))<CR>'




" -- VimPolyglot
let g:polyglot_disabled = ['autoindent']

" plugin manager options
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo'.data_dir.'/autoload/plug.vim --create-dirs '.
    \'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin("~/.vim/plugged")

Plug 'ycm-core/YouCompleteMe'
Plug 'mkitt/tabline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'sukima/xmledit'
Plug 'vimsence/vimsence'
Plug 'jupyter-vim/jupyter-vim'

call plug#end()


" plugin options

" -- YCM
let g:ycm_add_previw_to_completeopt = 0
set completeopt-=preview

let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']

let g:ycm_echo_current_diagnostic = 'virtual-text'
let g:ycm_update_diagnostics_in_insert_mode = 0

nnoremap <leader>'q <plug>(YCMHover)
nnoremap <leader>'r :YcmCompleter RefactorRename 
nnoremap <leader>'f :YcmCompleter FixIt<CR> 
nnoremap <leader>'p :YcmCompleter Format<CR> 
nnoremap gd :YcmCompleter GoToDeclaration<CR>

let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'python',
  \     'cmdline': [ 'pylsp', '-v', '--log-file', '/tmp/pylsp.log' ],
  \     'filetypes': [ 'python' ]
  \   }
  \ ]


" -- JupyterVim
" Run current file
nnoremap <buffer> <silent> +r :JupyterRunFile<CR>

" Connect to Qt Console
nnoremap <buffer> <silent> +c :JupyterConnect<CR>

" Change to directory of current file
nnoremap <buffer> <silent> +d :JupyterCd %:p:h<CR>

" Send a selection of lines
nnoremap <buffer> <silent> +s :JupyterSendCell<CR>
" nnoremap <buffer> <silent> <localleader>E :JupyterSendRange<CR>
" nmap     <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
" vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

" Debugging maps
" nnoremap <buffer> <silent> <localleader>b :PythonSetBreak<CR>


" -- Theme
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext


" Enable swap file warnings (what's disabling them?)
set shortmess-=A

" https://www.reddit.com/r/vim/comments/6qfhob/how_to_make_vim_follow_terminals_colorscheme/
set termguicolors

" Wrap text by default
set nowrap

" :set [option]?            ==> print current value for given option
" :echo [var]               ==> print current value for given var
" :verbose set [option]?    ==> print current value for given option
