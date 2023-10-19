" set leader key to spacebar
let g:mapleader = ' '

" comment strings and numbers in C comments
let g:c_comment_strings=1

" block cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"


" enable syntax highlighting
syntax on


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set ai            " always set autoindenting on
set si            " smart indent
set viminfo='20,\"50    " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set wildmenu        " display completion matches in a status line

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=3

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" window split options
set splitright
set splitbelow

" relative line numbers
set nu
set rnu

" search options ('/' and '?')
set incsearch
set nohlsearch
set ignorecase
set smartcase

" max number of tabs
set tabpagemax=100

" Do not wrap text by default
set nowrap

" https://www.reddit.com/r/vim/comments/6qfhob/how_to_make_vim_follow_terminals_colorscheme/
set termguicolors


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

" move selected lines when in visual mode (countable!!!)
vnoremap <expr> <C-J> ":m .+" . v:count1 . "<CR>gv=gv"
vnoremap <expr> <C-K> ":m .-" . (v:count1 + 1) . "<CR>gv=gv"

" Perl substitution
noremap S :perldo s//g<left><left>

" capital y with d-like behavior
noremap Y y$

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

" quick spell suggestion
noremap zq 1z=
inoremap <C-L> <Esc>[s1z=`]a

" comment lines
" TODO autocmd to switch between terminators
nnoremap çç mpI//<Esc>mp
nnoremap Ç mpi//<Esc>mp
vnoremap ç mp<Esc>`>a*/<Esc>`<i/*<Esc>mp

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

" CRLF to LF
noremap <leader>ml :e ++ff=unix<CR>:perldo s/\r//g<CR>

" delete trailing white space
command! Trim :perldo s/\s+$//gm
noremap <leader>mt :Trim<CR>

" convert tabs to spaces (needs some fixing)
command! TabsToSpaces :perldo s/\t/    /gm
noremap <leader>ms :TabsToSpaces<CR>

" vertical guideline
set colorcolumn=100

" tab size
" filetype plugin indent on
set expandtab
set tabstop=4
set softtabstop=-1
set shiftwidth=4

autocmd FileType xml  setlocal shiftwidth=2
autocmd FileType html setlocal shiftwidth=2
autocmd FileType pug  setlocal shiftwidth=2

" use mouse for scrolling
set mouse=a


" toggle wrap
noremap <leader>mw :set wrap!<CR>

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


filetype plugin on

" -- VimPolyglot
let g:polyglot_disabled = ['autoindent', 'csv']
let g:perl_sub_signatures = 1

" plugin manager options
let data_dir = "~/.vim/autoload/plug.vim"
if empty(glob(data_dir))
    silent execute '!curl -fLo '.data_dir.' --create-dirs '.
    \'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin("~/.vim/plugged")

Plug 'ycm-core/YouCompleteMe'   " LSP manager (Python, C, C++, Java, Rust, JS)
Plug 'mkitt/tabline.vim'        " Tabline skin
Plug 'sheerun/vim-polyglot'     " Rich syntax highlight
Plug 'mhartington/oceanic-next' " Color scheme
Plug 'vim-airline/vim-airline'  " Status bar
Plug 'sukima/xmledit'           " Self explanatory
Plug 'jupyter-vim/jupyter-vim'  " Connect to Jupyter console

call plug#end()


" plugin options

" -- YCM
let g:ycm_add_previw_to_completeopt = 0
set completeopt-=preview

let g:ycm_global_ycm_extra_conf = "~/.config/ycm_extra_conf.py"

let g:ycm_echo_current_diagnostic = 'virtual-text'
let g:ycm_update_diagnostics_in_insert_mode = 0
let g:ycm_auto_hover = ''
" let g:ycm_enable_inlay_hints = 1
" let g:ycm_clear_inlay_hints_in_insert_mode = 1

nnoremap K <plug>(YCMHover)
nnoremap <leader>'r :YcmCompleter RefactorRename 
nnoremap <leader>'f :YcmCompleter FixIt<CR> 
nnoremap <leader>'p :YcmCompleter Format<CR> 
nnoremap <leader>'o :YcmCompleter GoToDocumentOutline<CR>
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

" New cell
nnoremap +n o## BEGIN<CR><CR><CR>## END<Esc>kO
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

" Enable font ligatures
set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~

" :set [option]?            ==> print current value for given option
" :echo [var]               ==> print current value for given var
" :verbose set [option]?    ==> print current value for given option and where it was defined

" change viminfo default path
set viminfo+=n~/.vim/viminfo

" Only do this part when compiled with support for autocommands
augroup myrc
    autocmd!
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis

nnoremap <leader>md :DiffOrig<CR>za
