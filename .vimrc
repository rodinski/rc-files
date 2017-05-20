"set lines=20

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set softtabstop=4
set laststatus=2
"set columns=80

set nocompatible
syntax on
filetype plugin indent on
set hidden

"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
colorscheme darkblue
"set guifont=Courier_new:h14:cANSI
set visualbell
set relativenumber "number the lines
set ignorecase
set virtualedit+=block
setlocal spell
set nospell
set backup
set writebackup 
set directory=./backup,~/tmp/vim//
set backupdir=./backup,~/tmp/vim//
set pheader=%<%f%h%m%40{strftime(\"%I:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}%=Page\ %N

set diffexpr=MyDiff()
"set cmdheight=2

"noremap <F4> :w <CR>:!awk -f  % *.txt<CR>
noremap <F5> :w <CR>:!perl  %<CR>
noremap <F6> :w <CR>:!perl -c %<CR>
" Execute current file
nnoremap <F7> :call ExecuteFile()<CR>
noremap <F8> <Esc> :w <CR>:!sqlite3 test_frame06.sqlite < %<CR>
noremap / /\v/V<Left><Left>


"other maps to geting an Esc
inoremap ;; <Esc>l
"inoremap jk <Esc>l

" insert a  tab  with  \<tab>
" to insert a real <Tab>  type  "\<tab>" quickly
inoremap <Leader><Tab> <Tab>
" ^ mark=location at last insert stop
" is au VimEnter not use other mappings seem to interfear 
"au VimEnter * inoremap <Tab> <Esc>`^
"au VimEnter * vnoremap <Tab> <Esc>`^
noremap ;; :%s:\v::g<Left><Left><Left>
vnoremap ;; :s:\v::g<Left><Left><Left>

noremap <leader>ev :split $MYVIMRC<CR>
noremap <leader>sv :source $MYVIMRC<CR>
" clear the search registar
noremap <leader>c  :let @/ = ""<CR>
nmap <leader>ss  i<CR><BS><BS>skip<Tab>
imap <leader>ss  <CR><BS><BS>skip<Tab>
noremap <leader>gt <Esc>qaq:g//:y A<CR> :tabnew<CR>"Ap<CR>

" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter> :let @/ = ""<CR>
vmap _C :s/^#//gi<Enter> :let @/ = ""<CR>

" my perl includes pod
let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

" Tidy selected lines (or entire file) with _t:
nnoremap  _t :%!perltidy -q<Enter>
vnoremap  _t :!perltidy -q<Enter>


:highlight TablineSel cterm=reverse
:highlight TablineFill none
" make and restore view so that folds are saved
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview


" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org> Last change:	2008 Jul 02
"
" To use it, copy it to for Unix and OS/2:  ~/.vimrc for Amiga:  s:.vimrc for
" MS-DOS and Win32:  $VIM\_vimrc for OpenVMS:  sys$login:.vimrc
"
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish 
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"    set nobackup		" do not keep a backup file, use versions instead 
"  else 
"    set backup		" keep a backup file
"endif 

set history=90		" keep 50 lines of command line history 
set ruler		" show the cursor position all the time 
set showcmd             " display incomplete commands 
set incsearch	        " do incremental searching
"set lines=50


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so
" that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse') 
  set mouse=a 
endif

" Switch syntax highlighting on, when the terminal has colors Also switch on
" highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
"   syntax on 
   set hlsearch 
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
  autocmd FileType perl setlocal sts=4
  autocmd FileType yaml setlocal sts=2 sw=2 nosmartindent nocindent indentkeys-=<:> expandtab 
  autocmd FileType yaml inoremap ` <c-r>=TriggerSnippet()<cr>
  autocmd FileType yaml snoremap ~ <esc>i<right><c-r>=TriggerSnippet()<cr>
    
  au FileType perl source /usr/share/vim/vim74/ftplugin/perl_doc.vim

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
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
if !exists(":DiffOrig") 
  command DiffOrig vert new | set bt=nofile | r # | 0d_	| diffthis 
                            \ | wincmd p | diffthis 
endif


"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction


command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction




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



" Copy matches of the last search to a register (default is the clipboard).
" Accepts a range (default is whole file).
" 'CopyMatches'   copy matches to clipboard (each match has \n added).
" 'CopyMatches x' copy matches to register x (clears register first).
" 'CopyMatches X' append matches to register x.
" We skip empty hits to ensure patterns using '\ze' don't loop forever.
command! -range=% -register CopyMatches call s:CopyMatches(<line1>, <line2>, '<reg>')

function! s:CopyMatches(line1, line2, reg)
  let hits = []
  for line in range(a:line1, a:line2)
    let txt = getline(line)
    let idx = match(txt, @/)
    while idx >= 0
      let end = matchend(txt, @/, idx)
      if end > idx
	call add(hits, strpart(txt, idx, end-idx))
      else
	let end += 1
      endif
      if @/[0] == '^'
        break  " to avoid false hits
      endif
      let idx = match(txt, @/, end)
    endwhile
  endfor
  if len(hits) > 0
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
  else
    echo 'No hits'
  endif
endfunction

" first, enable status line always
set laststatus=2

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=magenta
  elseif a:mode == 'r'
    hi statusline guibg=blue
  else
    hi statusline guibg=red
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=green

" default the statusline to green when entering Vim
hi statusline guibg=green
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [%p%%]\ [L=%l\ [C=%c]]\ [LEN=%L]\ [%{mode()}]


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



au BufRead,BufNewFile *.ino,*.pde set filetype=cpp
