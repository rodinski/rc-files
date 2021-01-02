set nocompatible " be iMproved"

" Vundle Setup Type Things {{{
" ----------------------------
if !empty(glob("/home/rod/.vim/bundle")) "Check for Vundle Direcory
"   echo "File exists."
"   echo "need to load things for vundle"
    filetype off      " required

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " The following are examples of different formats supported.
    " Keep Plugin commands between vundle#begin/end.
    " plugin on GitHub repo
    " Plugin 'tpope/vim-fugitive'

    " plugin from http://vim-scripts.org/vim/scripts.html
    " Plugin 'L9'

    " Git plugin not hosted on GitHub
    "Plugin 'git://git.wincent.com/command-t.git'

    " git repos on your local machine (i.e. when working on your own plugin)
    "Plugin 'file:///home/gmarik/path/to/plugin'

    " The sparkup vim script is in a subdirectory of this repo called vim.
    " Pass the path to set the runtimepath properly.


    Plugin 'Align'
"    Plugin 'Tabular'
"    Plugin 'snipMate'
"    Plugin 'SQLUtilities'
"    Plugin 'dbext4rdb'
"    Plugin 'perldoc'
    " open help on the keywork on cursor with K
    Plugin 'PERLDOC2'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'wolfgangmehner/awk-support'

    " All of your Plugins must be added before the following line
    call vundle#end()            " required

    filetype plugin indent on    " required

    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    " :PluginList          - list configured plugins
    " :PluginInstall(!)    - install (update) plugins
    " :PluginSearch(!) foo - search (or refresh cache first) for foo
    " :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
    "
    " see :h vundle for more details or wiki for FAQ
    " Put your non-Plugin stuff after this line
endif
"}}}
filetype plugin indent on

" Backups {{{
" -----------
set backup
if has("win32")
  "Windows options here
  set directory=./backup,~/tmp/vim//
  set backupdir=./backup,~/tmp/vim//
else
   "unix
  set backupdir=~/.vim/backup
  set directory=~/.vim/tmp
    if has("unix")
       let s:uname = system("uname")
    endif
endif
set writebackup
"}}}



" gui {{{
" -----------
if has("gui_running")
   !perlbrew switch perl-5.24.1
   let g:Perl_Executable = 'perl'
endif
"}}}







" Language & encoding{{{
" ----------------------
set encoding=utf-8
set fileencodings=utf-8,latin-1
"}}}

" Text Format {{{
" ---------------
set tabstop=4
set softtabstop=4 " backspace can delete 2 space a time
set shiftwidth=4  " Tabs under smart indent
"set smarttab
"
set nowrap
set autoindent
set smartindent
set expandtab
set backspace=2   " Delete everything with backspace
set formatoptions+=c         " add comments
set formatoptions+=r         " add comment leader
set formatoptions+=q         " allow gq to format
set formatoptions-=a         " not automatic paragraphs
set formatoptions-=t         " not automatic linewrap at textwidth


"}}}

" View Setup {{{
" ---------------
colorscheme darkblue
set laststatus=2
set splitbelow splitright                           " new windows to down or right
set showcmd                                         " display incomplete commands
set ruler                                           " show the cursor position all the time
set visualbell                                      " ruler
set history=90                                      " keep 50 lines of command line history
set hlsearch                                        " highlight all match of seach reg
set incsearch                                       " do incremental searching
syntax on
"set guifont=Courier_new:h14:cANSI
set number                                  " number the lines
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"set hidden                  " hidden buffers
set ignorecase
set autochdir                  " change dir to the current buffer
set virtualedit+=block          " allows going beyond EOL
setlocal spell
set nospell
" print header
set pheader=%<%f%h%m%40{strftime(\"%I:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}%=Page\ %N

set diffexpr=MyDiff()
function! MyDiff()
    let opt = ''
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    silent execute '!diff -a ' . opt . v:fname_in . ' ' . v:fname_new . ' > ' . v:fname_out
endfunction


" make and restore view so that folds are saved
au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview
au BufWinEnter *.pl,*.bdf,*.awk  loadview
"}}}

" Mappings {{{
" ---------------

" Execute current file
inoremap <F8> <Esc><Esc>:update<CR>:!sqlite3  < %<CR>


"invert line number settings
nmap <leader>ii :set invrelativenumber<CR>
nmap <leader>nn :set invnumber<CR>

"other maps to geting an Esc
inoremap kj <Esc>l
inoremap jk <Esc>l
" to insert a real <Tab>  type  "\<tab>" quickly
inoremap <Leader><Tab> <Tab>
" substitutions
noremap ;; :%s:::g<Left><Left><Left>
vnoremap ;; :s:::g<Left><Left><Left>
" Alt  is has a :help "key-notation" <M-?>
inoremap <M-m> <Esc>l
" remove trailing spaces and save location
noremap <Leader>ss <Esc><Esc>mm:%s: \+$::g<CR>'m


"edit or source the $MYVIMRC
noremap <leader>ev :split $MYVIMRC<CR>
noremap <leader>sv :source $MYVIMRC<CR>
"global lines to new tab
noremap <leader>gt <Esc>qaq:g//:let @a .= getline('.')."\n"<CR> :tabnew<CR>"aPGdd<CR>

" clear the search registar
noremap <leader>c  :let @/ = ""<CR>


nnoremap <leader>cd :cd %:p:h<CR>
" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter> :let @/ = ""<CR>
vmap _C :s/^#//gi<Enter> :let @/ = ""<CR>

"window shortcuts  CTRL + hjkl
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-Left>  :vertical resize +2<CR>
noremap <C-Right> :vertical resize -2<CR>

noremap <C-Up>  :resize +2<CR>
noremap <C-Down>  :resize -2<CR>

"indents
nnoremap >> mm>>`m
nnoremap << mm<<`m

" comment/uncomment blocks of code (in vmode)
vmap <leader>cc :s/^/#/gi<Enter> :let @/ = ""<CR>
vmap <leader>cn :s/^#//gi<Enter> :let @/ = ""<CR>

"}}}

" Perl {{{
" ---------------
set tags+=~/.ptags
" my perl includes pod
let perl_include_pod = 1
" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1
" Tidy selected lines (or entire file) with _t:
nnoremap  _t :%!perltidy -q<Enter>
vnoremap  _t :!perltidy -q<Enter>
"}}}


:highlight TablineSel cterm=reverse
:highlight TablineFill none



" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.  Use the default filetype settings, so that
  " mail gets 'tw' set to 72, 'cindent' is on in C files, etc.  Also load
  " indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  autocmd FileType perl setlocal ts=2 sts=4 sw=2 smartindent expandtab
  autocmd FileType perl setlocal cindent
"  autocmd FileType perl keywordprg=perldoc\ -T\ -f
"  autocmd FileType perl  keywordprg=perldoc\ -f

  autocmd FileType perl  setlocal sts=4 ts=4 sw=0 smartindent cindent
  autocmd FileType awk   setlocal sts=4 ts=4 sw=0 smartindent cindent

  autocmd FileType python  noremap <F5> :w<CR>:RunPython<CR>
  autocmd FileType python  noremap <F6> :w<CR>:!python  %<CR>

  autocmd FileType perl  noremap <F5> :w<CR>:RunPerl<CR>
  autocmd FileType perl  noremap <F6> :w<CR>:TestPerl<CR>

  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 nosmartindent nocindent indentkeys-=<:> expandtab
  autocmd FileType yaml inoremap ` <c-r>=TriggerSnippet()<cr>
  autocmd FileType yaml snoremap ~ <esc>i<right><c-r>=TriggerSnippet()<cr>


" When editing a file, always jump to the last known cursor position.  Don't
" do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).  Also don't do it when the mark is
  " in the first line, that is the default position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
       \ exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent        " always set autoindenting on
endif " has("autocmd")



" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                            \ | wincmd p | diffthis
endif



" TabMessage {{{
" --------------
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
"}}}

" JoinTab {{{
" -----------
"by RMH June 7, 2011
"by RMH Jan 22, 2013 added check for one line call
"use V-line block to highlight lines then this will
"join those lines with a tab character
command! -range JoinTab <line1>,<line2>call Jointabrmh()
function! Jointabrmh() range
    if a:firstline==a:lastline
    return
    endif
    let alist=getline(a:firstline,a:lastline)
    let blist=join(alist,"\t")
    exe a:firstline+1','a:lastline'd'
    call setline(a:firstline,blist)
    return (a:lastline)
endfunction
"}}}

" InsertStatuslineColor {{{
" ---------------
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=magenta
  elseif a:mode == 'r'
    hi statusline guibg=blue
  else
    hi statusline guibg=red
  endif
endfunction
"}}}

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=green

" default the statusline to green when entering Vim
hi statusline guibg=green
set statusline=%F%m%r%h%w\ \ \|B=%n\ FORMAT=%{&ff}\ TYPE=%Y\ %p%%\ L=%l\ C=%v\%{mode()}\ Arg=%a


""""""""""""""""""""""""""""""""
"""" Script in CURRENT FILE """
"""""""""""""""""""""""""""""""

" Will attempt to execute the current file based on the `&filetype`
" You need to manually map the filetypes you use most commonly to the
" correct shell command.
function! ExecuteFile()
  let filetype_to_command = {
  \   'PYTHON': 'python3',
  \   'python': 'python3',
  \   'html': 'open',
  \   'sh': 'sh',
  \   'pl': 'perl -w'
  \ }
  let cmd = get(filetype_to_command, &filetype, &filetype)
  call RunShellCommand(cmd." %s")
endfunction

" RunShellCommand "{{{
" --------------------
" Enter any shell command and have the output appear in a new buffer
" For example, to word count the current file:
"
"   :Shell wc %s
"
" Thanks to: http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call RunShellCommand(<q-args>)
function! RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
"}}}

" dbext {{{

function! DBextPostResult(db_type, buf_nr)
    "if a:db_type == 'SQLITE'
        " Assuming the first column is an integer
        " highlight it using the WarningMsg color
        syn match logWarn '^\d\+'
        syn match logWarn '\d\+ *$'
        hi def link logWarn		WarningMsg
    "endif
endfunction

let g:dbext_default_profile_sqlite = 'type=SQLITE:dbname=/usr/bin/sqlite3'
let g:dbext_default_SQLITE_bin  = '/usr/bin/sqlite3'
"}}}
au BufRead,BufNewFile *.ino,*.pde set filetype=cpp"}}}

let g:Perldoc_path='/home/rod/bin/perldoc/'



"python with virtualenv support
python3 << EOF
import os
import sys
"""
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
"""
EOF

function! RunCmd(cmd)
  let fn = expand("%:p")
  let ft = &l:filetype
  let fp = expand("%:p:h")
  let short_name = expand ("%")
  botright copen
  execute "lcd ".fp
  setlocal modifiable
  %d _
  silent execute "read !".a:cmd." ".fn
  1d _
  " use the folder path fn to make a new seach pattern
  let new_fn =  substitute(fn,"\\",".",'gei')
  echo new_fn
  " path and name can be long and I don't want to see it
  execute "silent! %s?" .new_fn. "?" . short_name . "?"
  normal! G
  if ft != ""
    execute "setf ".ft
  else
    setlocal filetype=
  endif
  setlocal nomodifiable nomodified
  let fn_txt = fn . ".out"
  execute "set nowrap"
  "execute "sav " fn_txt
  wincmd p
endfunction

command! -nargs=1 Run     call RunCmd(<q-args>)
"command!          RunPerl call RunCmd("/usr/bin/perl")
command!  RunPerl  call RunCmd("c:/Strawberry/perl/bin/perl.exe    -w")
command!  TestPerl  call RunCmd("c:/Strawberry/perl/bin/perl.exe -c -w")
command!  RunPython  call RunCmd("/home/rod/Python_VE/cogo/bin/python3 -h   ")
"command!  RunAWK call RunCmd("awk.exe --file %". b:awkfile)
"command!  TestAWK call RunCmd("awk.exe  --source 'BEGIN { exit(0) } END { exit(0) }' --file " )


function! CopyMatches(reg)
    let hits = []
    %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
