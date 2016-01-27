""" .vimrc file """
"
" To install:
"  $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"  $ vim +PluginInstall +qall (or run vim, then :PluginInstall)
"
" Other dependencies: (system-wide)
"  - Exuberant-ctags
"   $ yum install ctags
"  - vim-debug (now disabled)
"   $ sudo pip install vim-debug

" No vi-compatible
set nocompatible

" ---===[ Vundle installation ]===--- "
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
    let iCanHazVundle=0
endif

" Required for vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle (required!)
Bundle 'gmarik/Vundle.vim'

" ---===[ Plugins ]===--- "
" === Debugers === "
" Python and PHP Debugger (this requires vim-debug Python package)
" (old/outdated)
"Bundle 'fisadev/vim-debug.vim'

" === Plugins adding UI elements === "
" Airline
Bundle 'bling/vim-airline'
" Class/module browser <F8> to toggle
Bundle 'majutsushi/tagbar'
" Better file browser
Bundle 'scrooloose/nerdtree'
" Tab list panel (better tab management) tl / tf
Bundle 'kien/tabman.vim'
" Pending tasks list (search for TODO/FIXME) :TaskList / <F2>
Bundle 'fisadev/FixedTaskList.vim'
" Consoles as buffers :ConqueTerm <cmd>
Bundle 'ardagnir/conque-term'
" Code commenter (unused)
"Bundle 'scrooloose/nerdcommenter'
" Indent text object (unused)
"Bundle 'michaeljsmith/vim-indent-object'
"Bundle 'taglist.vim' (replaced by tagbar)

" === Extra features / functionality === "
" Code and files fuzzy finder
Bundle 'ctrlpvim/ctrlp.vim'
" Toolkit for webdev (HTML/CSS workflow)
Bundle 'mattn/emmet-vim'
" Obsession (better Vim session persisting)
Bundle 'tpope/vim-obsession'
" Surround (edit parenthesis/brackets/quotes/xml/etc in pairs)
Bundle 'tpope/vim-surround'
" Autoclose (auto-complete open/closing pairs of chars)
Bundle 'Townk/vim-autoclose'
" Search results counter (shows match count on searching)
Bundle 'IndexedSearch'
" Snippets manager (SnipMate), dependencies, and snippets repo
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
" Expand matching beyond single char to words/regex with %
Bundle 'matchit.zip'
" Yank history navigation (:YRShow)
Bundle 'YankRing.vim'
" Extension to ctrlp, for fuzzy command finder (unused)
"Bundle 'fisadev/vim-ctrlp-cmdpalette'
" Better autocompletion (currently unused)
"Bundle 'Shougo/neocomplete.vim'

" === Git integration === "
" Git integration
Bundle 'motemen/git-vim'
" Git wrapper
Bundle 'tpope/vim-fugitive'
" Git diff icons on the side of the file lines
Bundle 'airblade/vim-gitgutter'

" === Colorschemes === "
" GVim colorscheme support
Bundle 'CSApprox'
" Terminal Vim with 256 colors colorscheme (unused)
"Bundle 'fisadev/fisa-vim-colorscheme'

" === Old / deprecated stuff === "
" Automatically sort python imports
"Bundle 'fisadev/vim-isort'
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative 
" numbering every time you go to normal mode. Author refuses to add a setting 
" to avoid that)
" Bundle 'myusuf3/numbers.vim'
" Bundles from vim-scripts repos

" === File-specific support === "
" === C support === "
Bundle 'c.vim'
"Bundle 'vim-scripts/c-support'                                                                                                          
" === Python support === "
" A set of menus/shortcuts to work with Python files
Bundle 'python.vim'
" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
Bundle 'klen/python-mode'
" Python code checker
"Bundle 'pyflakes.vim'
" Flake8 checker
Bundle 'nvie/vim-flake8'

" === Pig support === "
Bundle "motus/pig.vim"

" === Finish vundle config === "
" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
call vundle#end()

" ---===[ VIM configuration ]===--- "

" Allow plugins by file type
filetype plugin on
filetype indent on

" Tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Set auto-indent
set ai

" Configure backspace (bs=2)
set backspace=indent,eol,start

" Tablength exceptions
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Always show status bar
set ls=2

" Incremental search
set incsearch

" Highlighted search results
set nohlsearch

" Syntax highlight on
syntax on

" Line numbers
set nu

" Disable resizing of windows after split/close
set noea

" Turn on cursorline
"set cursorline

" Tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" Navigate windows with meta+arrows
map <M-Right> <c-w>l
map <M-Left> <c-w>h
map <M-Up> <c-w>k
map <M-Down> <c-w>j
imap <M-Right> <ESC><c-w>l
imap <M-Left> <ESC><c-w>h
imap <M-Up> <ESC><c-w>k
imap <M-Down> <ESC><c-w>j

" Copy & paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" When scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" ---===[ Plugin configuration ]===--- "

" Old autocomplete keyboard shortcut
"imap <C-J> <C-X><C-O>

" === Vim debug === "
" Debugger keyboard shortcuts
"let g:vim_debug_disable_mappings = 1
"map <F5> :Dbg over<CR>
"map <F6> :Dbg into<CR>
"map <F7> :Dbg out<CR>
"map <F8> :Dbg here<CR>
"map <F9> :Dbg break<CR>
"map <F10> :Dbg watch<CR>
"map <F11> :Dbg down<CR>
"map <F12> :Dbg up<CR>


" === Airline === "
" Settings
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
" Explicitially list classes in Python
" To manually load after VIM is started:
"   :let g:airline#extensions#tagbar#flags = 'f'
"   :let g:tagbar_type_python = { 'kinds' : [ 'i:imports:1:0', 'c:classes:1', 'f:functions', 'm:members', 'v:variables:0:0' ] }
"   :AirlineRefresh
let g:airline#extensions#tagbar#flags = 'f'
let g:tagbar_type_python = {
    \ 'kinds' : [
        \ 'i:imports:1:0',
        \ 'c:classes:1',
        \ 'f:functions',
        \ 'm:members',
        \ 'v:variables:0:0',
    \ ],
\ }
" To use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
"if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'

" === Tagbar === "
" Toggle Tagbar display
map <F4> :TagbarToggle<CR>
" Autofocus on Tagbar open
let g:tagbar_autofocus = 1

" === NERDTree === "
" Toggle
map <F3> :NERDTreeToggle<CR>
" Ignore files
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" === Tabman === "
" Shortcuts
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" === FixedTaskList.vim === "
" Show pending tasks list
map <F2> :TaskList<CR>


" === CtrlP === "
let g:ctrlp_map = ',e'
nmap ,g :CtrlPBufTag<CR>
nmap ,G :CtrlPBufTagAll<CR>
nmap ,f :CtrlPLine<CR>
nmap ,m :CtrlPMRUFiles<CR>
nmap ,c :CtrlPCmdPalette<CR>
" To be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" CtrlP with default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" Don't change working directory
let g:ctrlp_working_path_mode = 0
" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$',
  \ }

" === vim-autoclose === "
" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" === YankRing === "
" store yankring history file hidden
let g:yankring_history_file = '.yankring_history'

" === Neocomplete / neocomplcache === "
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 0
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_enable_fuzzy_completion = 1
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_fuzzy_completion_start_length = 1
"let g:neocomplcache_auto_completion_start_length = 1
"let g:neocomplcache_auto_completion_start_length = 1
"let g:neocomplcache_manual_completion_start_length = 1
"let g:neocomplcache_min_keyword_length = 1
"let g:neocomplcache_min_syntax_length = 3
"" complete with workds from any opened file
"let g:neocomplcache_same_filetype_lists = {}
"let g:neocomplcache_same_filetype_lists._ = '_'
"" Plugin key-mappings.
""inoremap <expr><C-g>     neocomplcache#undo_completion()
""inoremap <expr><C-l>     neocomplcache#complete_common_string()
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return neocomplcache#smart_close_popup() . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
"" Close popup by <Space>.
""inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"


" === GitGutter === "
" Fix some problems with gitgutter and other plugins (originally jedi-vim,
" but left just in case, and it's faster)
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0
let g:gitgutter_max_signs = 1000


" === python-mode === "
" Don't show lint result every time we save a file
let g:pymode_lint_on_write = 0
" Run pep8+pyflakes+pylint validator with \8
autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>
" Rules to ignore (example: "E501,W293")
let g:pymode_lint_ignore = "E501,E231,E303,E701"
" Don't add extra column for error icons (on console vim creates a 2-char-wide
" extra column)
let g:pymode_lint_signs = 0
" Don't fold python code on open
let g:pymode_folding = 0
" Don't load rope by default. Change to 1 to use rope
let g:pymode_rope = 0
" Open definitions on same window, and with my custom mapping
let g:pymode_rope_goto_definition_bind = ',d'
let g:pymode_rope_goto_definition_cmd = 'e'
" Rope (from python-mode) settings
nmap ,D :tab split<CR>:PymodePython rope.goto()<CR>
nmap ,o :RopeFindOccurrences<CR>

" === pyflakes === "
" Don't let pyflakes allways override the quickfix list
let g:pyflakes_use_quickfix = 0


" ---===[ Colorscheme setup ]===---- "
" Use 256 colors when possible
if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
	let &t_Co = 256
endif

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme liquidcarbon

" ---===[ Other custom functions / configs ]===--- "
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" Make :W work like :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" Map Command-W to write files with sudo
"command WW :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Save as sudo
ca w!! w !sudo tee "%"

" Simple recursive grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
nmap ,R :RecurGrep 
nmap ,r :RecurGrepFast 
nmap ,wR :RecurGrep <cword><CR>
nmap ,wr :RecurGrepFast <cword><CR>

" Highlight cursorline only in current window
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Provide function to do a diff of the currently edited file
" and unmodified version on the filesystem
" http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! RefreshWindow()
    bufdo e!
endfunction
nmap <leader>gr call RefreshWindow()

" Fold Python comments helper
function! PyFoldComments()
    set fdm=expr
    set fde=getline(v:lnum)=~'^\\s#'?1:getline(prevnonblank(v:lnum))=~'^\\s#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0
endfunction
nmap <leader>pf :call PyFoldComments()<CR>

" Shortcut for toggling scrollbind
nmap <silent> <leader>sb :set scb!<CR>

" Shortcut for toggling wrap
nmap <silent> <leader>sw :set wrap!<CR>


