set nocompatible " be iMproved"
  
" Vundle Setup Type Things {{{
" ----------------------------
if !empty(glob("/home/rod/.vim/bundle")) "Check for Vundle Direcory
   echo "File exists."
   echo "need to load things for vundle"
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
    Plugin 'git://git.wincent.com/command-t.git'

    " git repos on your local machine (i.e. when working on your own plugin)
    Plugin 'file:///home/gmarik/path/to/plugin'

    " The sparkup vim script is in a subdirectory of this repo called vim.
    " Pass the path to set the runtimepath properly.
    Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

    " Avoid a name conflict with L9
    "Plugin 'user/L9', {'name': 'newL9'}

    Plugin 'Align'  
    Plugin 'Tabular'
    Plugin 'snipMate'
    Plugin 'SQLUtilities'
    Plugin 'dbext4rdb'
    Plugin 'perldoc'
    " open help on the keywork on cursor with K
    Plugin 'PERLDOC2'

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
set smarttab
"
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
colorscheme morning
set laststatus=2
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
set hidden                      " hidden buffers
set ignorecase
set autochdir                   " change dir to the current buffer 
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
au BufWinEnter *.* silent loadview
"}}}

" Mappings {{{
" ---------------
" run / check perl code 
noremap <F5> :w <CR>:!perl  %<CR>
noremap <F6> :w <CR>:!perl -c %<CR>

" Execute current file
noremap <F8> <Esc> :w <CR>:!sqlite3 test_frame06.sqlite < %<CR>

"invert line number settings
nmap <leader>ii :set invrelativenumber<CR>
nmap <leader>nn :set invnumber<CR>

"other maps to geting an Esc
inoremap kj <Esc>l            
inoremap jk <Esc>l
inoremap <Tab> <Esc>l
inoremap <C-k> <Esc>l
inoremap <A-k> <Esc>j
inoremap <A k> <Esc>j

" to insert a real <Tab>  type  "\<tab>" quickly
inoremap <Leader><Tab> <Tab>   
noremap  ;; :%s:::g<Left><Left><Left>
vnoremap ;; :s:::g<Left><Left><Left>
" Alt  is has a :help "key-notation" <M-?>
inoremap <M-m> <Esc>l

" to insert a real <Tab>  type  "\<tab>" quickly
inoremap <Leader><Tab> <Tab>   
"
noremap ;; :%s:::g<Left><Left><Left>
vnoremap ;; :s:::g<Left><Left><Left>

"edit or source the $MYVIMRC
noremap <leader>ev :split $MYVIMRC<CR>
noremap <leader>sv :source $MYVIMRC<CR>
"global lines to new tab
noremap <leader>gt <Esc>qaq:g//:y A<CR> :tabnew<CR>"Ap<CR>  

" clear the search registar
noremap <leader>c  :let @/ = ""<CR>     
nmap <leader>ss  i<CR><BS><BS>skip<Tab> 
imap <leader>ss  <CR><BS><BS>skip<Tab>
" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter> :let @/ = ""<CR>
vmap _C :s/^#//gi<Enter> :let @/ = ""<CR>
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


" An example for a vimrc file.
" Maintainer:   Bram Moolenaar <Bram@vim.org> Last change:  2008 Jul 02
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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

  autocmd FileType perl setlocal ts=4 sts=4 sw=2 smartindent expandtab

  autocmd  FileType perl  setlocal sts=4 ts=4 smartindent cindent
  autocmd  FileType perl  nnoremap <F5> :update<CR>:RunPerl<CR>
  autocmd  FileType perl  inoremap <F5> <ESC>:update<CR>:RunPerl<CR>li
  autocmd  FileType perl  vnoremap <F5> <Esc>:update<CR>:RunPerl<CR>gv
  autocmd  FileType perl  noremap  <F6> :update<CR>:TestPerl<CR>
  autocmd  FileType perl  inoremap <F6> <ESC>:update<CR>:TestPerl<CR>li
  autocmd  FileType perl  vnoremap <F5> <Esc>:update<CR>:TestPerl<CR>gv

  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 nosmartindent nocindent indentkeys-=<:> expandtab
  autocmd FileType yaml inoremap ` <c-r>=TriggerSnippet()<cr>
  autocmd FileType yaml snoremap ~ <esc>i<right><c-r>=TriggerSnippet()<cr>
    
  "au FileType perl source /usr/share/vim/vim74/ftplugin/perl_doc.vim

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
  \   'javascript': 'node',
  \   'coffee': 'coffee',
  \   'python': 'python',
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

function! RunCmd(cmd)
    let fn = expand("%:p")
    let ft = &l:filetype
    botright copen
    setlocal modifiable
    %d _
    silent execute "read !".a:cmd." ".fn
    1d _
    normal! G
    if ft != ""
      execute "setf ".ft
    else
      setlocal filetype=
    endif
    setlocal nomodifiable nomodified
    wincmd p
endfunction
"=============================
command! -nargs=1 Run     call RunCmd(<q-args>)
command! RunPerl  call RunCmd("/home/rod/perl5/perlbrew/perls/perl-5.24.1/bin/perl -w")
command! TestPerl call RunCmd("/home/rod/perl5/perlbrew/perls/perl-5.24.1/bin/perl -c -w")

"Execute sheel commands, send output to a new vsplit window
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shellv call s:ExecuteInShell(<q-args>)
"usage    :Shell <commands>


