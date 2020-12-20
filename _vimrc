set nocompatible " be iMproved"

" NOTE:  plugins that use the tempname() function
" seem to have a problem.  WHY??


" Vundle Setup Type Things {{{
" ----------------------------
if !empty(glob("C:/Users/rholcomb/vimfiles/bundle")) "Check for Vundle Direcory
   "echo "File exists."
   "echo "need to load things for vundle"
    filetype off      " required

    " set the runtime path to include Vundle and initialize
    set rtp+=C:/Users/rholcomb/vimfiles/bundle/Vundle.vim/
    "call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    call vundle#begin('C:/Users/rholcomb/vimfiles/bundle')

    " let Vundle manage Vundle, required
    Plugin 'Vundle.vim'

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
    "Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

    " Avoid a name conflict with L9
    "Plugin 'user/L9', {'name': 'newL9'}

"    Plugin 'Tabular'
    Plugin 'align'
"    Plugin 'snipMate'
    Plugin 'SQLUtilities'
"    Plugin 'dbext4rdb'
"    Plugin 'perldoc'
    " open help on the keywork on cursor with K
     Plugin 'wolfgangmehner/awk-support'
     Plugin 'PERLDOC2'
"    Plugin 'matze/vim-move'

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

"only count in decimal
set nrformats=bin
" Backups {{{
" -----------
set backup
if has("win32")
  "Windows options here
  let $TMP=expand('c:\TEMP\vim')
  "let $TMP=expand('~/AppData/Local/Temp')
  "let $TMPDIR=expand('~/AppData/Local/Temp')
  "let $TMP=.
  "let $TMPDIR=.
  set directory=./backup,C:/temp/vim
  set backupdir=./backup,C:/temp/vim
  "colorscheme slate
  "colorscheme delek
  "colorscheme desert
  colorscheme evening
  set lines=35 columns=140
  set cmdheight=2
  "use keypad
  noremap <kPlus> <C-A>
  noremap <kMinus> <C-X>
  if has("clipboard")
      set clipboard=unnamed
      " CTRL-X and SHIFT-Del are Cut
      vnoremap <C-X> "+x
      vnoremap <S-Del> "+x

      " CTRL-C and CTRL-Insert are Copy
      vnoremap <C-C> "+y
      vnoremap <C-Insert> "+y

      " CTRL-V and SHIFT-Insert are Paste
      "map <C-V>		"+gP
      map <S-Insert>		"+gP

      "cmap <C-V>		<C-R>+
      cmap <S-Insert>		<C-R>+
  endif

"another way to do autocmds
let fts = [ 'pl', 'pm', 'perl'  ]
if index(fts, &filetype) == -1
  let &keywordprg = '/Strawberry/perl/bin/perldoc.exe\ -f  '
  "setlocal keywordprg=/Strawberry/perl/bin/perldoc.exe\ -f
  setlocal makeprg=perl.exe\ -c\ %\ $*
  "call RunCmd("perl.exe -c -w")
  setlocal errorformat=%f:%l:%m
  setlocal autowrite
  " make tab in v mode indent code
  vmap <tab> >gv
  vmap <s-tab> <vg
  " make tab in normal mode indent code
  nmap <tab> I<tab><esc>
  nmap <s-tab> ^i<bs><esc>

  " quick hex code for formfeed \f
  cnoremap \f \%x0c

  nmap <Leader>pf :!perldoc -f <cword><CR>
  nmap <Leader>pm :!perldoc -m <cword><CR>

"toggle wrap
  map <Leader>w :set wrap!<CR>
endif

" autocmd FileType perl  setlocal keywordprg=c:\Strawberry\perl\bin\perldoc.exe
" nmap <Leader>pf :!perldoc -f <cword><CR>
" nmap <Leader>pm :!perldoc -m <cword><CR>
" "source c:/Program Files\ (x86)/Vim/vim80/mswin.vim
else
   "unix
  autocmd FileType perl  setlocal keywordprg=!perldoc
  colorscheme pablo
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
"set softtabstop=4 " backspace can delete 2 space a time
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

set printoptions+=formfeed:y " do a real break to next sheet

"}}}

" View Setup {{{
" ---------------
set laststatus=2
set splitbelow splitright                           " new windows to down or right
set showcmd                                         " display incomplete commands
set ruler                                           " show the cursor position all the time
set visualbell                                      " ruler
set history=90                                      " keep 50 lines of command line history
set hlsearch                                        " highlight all match of seach reg
set incsearch                                       " do incremental searching
syntax on
set guifont=Courier_new:h14:cANSI
set number                                  " number the lines
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"set hidden                  " hidden buffers
set ignorecase
set autochdir                  " change dir to the current bufferi
set virtualedit+=block          " allows going beyond EOL
setlocal spell
set nospell
" print header
set pheader=%<%f%h%m%40{strftime(\"%I:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}%=Page\ %N

"set diffexpr=MyDiff()
"function MyDiff()
"    let opt = ''
"    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"    silent execute '!diff -a ' . opt . v:fname_in . ' ' . v:fname_new . ' > ' . v:fname_out
"endfunction


" make and restore view so that folds are saved
au BufWinLeave *.pl,*.bdf,*.awk  mkview!
"au BufWinEnter *.* silent loadview
au BufWinEnter *.pl,*.bdf,*.awk  loadview
"}}}

" Mappings {{{
" ---------------

" Execute current file
inoremap <F8> <Esc><Esc>:update<CR>:!sqlite3  < %<CR>
nnoremap <F8> :update<CR>:!sqlite3  < %<CR>

"invert line number settings
nmap <leader>ii :set invrelativenumber<CR>
nmap <leader>nn :set invnumber<CR>

"other maps to geting an Esc
"only one <EsC> needed
"inoremap <Esc> <Esc><Esc>
" others have suggested setting ttimoutlength
set ttimeoutlen=0
inoremap kj <Esc><Esc>l
inoremap jk <Esc><Esc>l
inoremap <Tab> <Esc><Esc>l
" Alt  is has a :help "key-notation" <M-?>
inoremap <M-m> <Esc><Esc>l

" to insert a real <Tab>  type  "\<tab>" quickly
inoremap <Leader><Tab> <Tab>
"
noremap ;; :%s:::g<Left><Left><Left>
vnoremap ;; :s:::g<Left><Left><Left>

" remove trailing spaces and save location
"noremap <Leader><Space><Space> <Esc>mm:%s: \+$::g<CR>'m
noremap <Leader>ss <Esc><Esc>mm:%s: \+$::g<CR>'m


"edit or source the $MYVIMRC
noremap <leader>ev :split $MYVIMRC<CR>
noremap <leader>sv :source $MYVIMRC<CR>
"global lines to new tab
"noremap <leader>gt <Esc>qaq:g//:y A<CR> :tabnew<CR>"Ap<CR>
noremap <leader>gt <Esc>qaq:g//:let @a .= getline('.')."\n"<CR> :tabnew<CR>"aPGdd<CR>

" clear the search registar
noremap <leader>c  :let @/ = ""<CR>


nnoremap <leader>an ? [-0-9\.]<CR>l/[0-9\.]\ze[ \t$]<CR>
vnoremap <leader>an ? [-0-9\.]<CR>l/[0-9\.]\ze[ \t$]<CR>

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
"  autocmd FileType text setlocal textwidth=78
" run / check perl code
  "BDF files have lots of numbers in columns  add "-" and "." to keywords
  autocmd FileType bdf,rpt,rea
                   \ set iskeyword=@,48-57,45,46  |
                   \ setlocal sts=1 ts=1  nowrap expandtab



  autocmd FileType perl  setlocal sts=4 ts=4 sw=0 smartindent cindent
  autocmd FileType awk   setlocal sts=4 ts=4 sw=0 smartindent cindent

  autocmd FileType python  noremap <F5> :w<CR>:RunPython<CR>
  autocmd FileType python  noremap <F6> :w<CR>:!python  %<CR>

  autocmd FileType perl  noremap <F5> :w<CR>:RunPerl<CR>
  autocmd FileType perl  noremap <F6> :w<CR>:TestPerl<CR>
  "autocmd FileType perl  inoremap <F5> :w<CR><C-o>:up|RunPerl<CR>
  "autocmd FileType perl  vnoremap <F5> :w<CR><Esc>:up|RunPerl<CR>gv

" run / check awk code
"  autocmd FileType awk   noremap <F5> :w<CR>:RunAWK<CR>
"  autocmd FileType awk  noremap <F6> :w<CR>:TestAWK<CR>


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
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [%p%%]\ [L=%l\ [C=%c]]\ [LEN=%L]\ [%{mode()}]
set statusline=%.50f%m%r%h%w\ \|\ T=%Y\ %p%%\ L=%l\ C=%c\ LEN=%L\ [%{mode()}]


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
  \   'sql': 'sqlite3 < '
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


"Execute sheel commands, send output to a new vsplit window
function! s:ExecuteInShellv(command)
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
command! -complete=shellcmd -nargs=+ Shellv call s:ExecuteInShellv(<q-args>)
"Usage   :Shellv  dir /b

"}}}


" Deal with Large files "{{{
" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 " rmh changed 2020_07_ 
 setlocal undolevels=5
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

"}}}

au BufRead,BufNewFile *.ino,*.pde set filetype=cpp"}}}



" DBext "{{{
"function! DBextPostResult(db_type, buf_nr)
"    " If dealing with a MYSQL database
"    if a:db_type == 'MYSQL'
"        " Assuming the first column is an integer
"        " highlight it using the WarningMsg color
"        syn match logWarn '^\d\+'
"        hi def link logWarn		WarningMsg
"    endif
"endfunction

" SQLite

let g:dbext_default_type = 'SQLITE'
let g:dbext_default_dbname = 'C:\ps_tools\autopipe_output\HRH\new.sqlite'
let g:dbext_default_profile_HRH='type=SQLITE'
let g:dbext_default_profile_HRH='dbname=C:\ps_tools\autopipe_output\HRH\new.sqlite'
let g:dbext_default_profile_SHA_SHC = 'type=SQLITE:dbname=C:\ps_tools\autopipe\SHA_SHC_rev_E\new.sqlite'

let g:dbext_default_SQLITE_bin = '"C:\Program Files (x86)\GnuWin32\bin\sqlite3.exe"'
"let g:dbext_default_display_cmd_line = 1
"}}}
"

let g:Perldoc_path = 'c:\temp\perldoc'


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
command!  TestPerl call RunCmd("c:/Strawberry/perl/bin/perl.exe -c -w")
command!  RunPython  call RunCmd("python   ")
"command!  RunAWK call RunCmd("awk.exe --file %". b:awkfile)
"command!  TestAWK call RunCmd("awk.exe  --source 'BEGIN { exit(0) } END { exit(0) }' --file " )


function! CopyMatches(reg)
    let hits = []
    %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction

command! CleanIRH call s:Clean_irh()
function! s:Clean_irh()
    "lines that start with * delete first eight characters 
    g/^\* /normal 08x
    "lines that end in -  delete char and Join to lower line 
    g/-$/normal $xJ
endfunction


command! Date call s:Put_Date()
function! s:Put_Date()
    let s:date = strftime("%Y_%m_%d")
    " note the single space after the i, this addes a space prior to
    " yyyy_mm_dd
    execute "normal i " . s:date "\<Esc>"
endfunction



let g:sqlutil_keyword_case = '\U'
let g:sqlutil_align_comma = 1
let g:sqlutil_align_first_word = 1
let g:sqlutil_align_keyword_right = 1
let g:sqlutil_load_default_maps = 0

vnoremap \sf  <Plug>SQLUFormater<CR>
nnoremap \sf  <Plug>SQLUFormater<CR>
vnoremap \sfs <Plug>SQLUFormater<CR>
nnoremap \sfs <Plug>SQLUFormater<CR>

