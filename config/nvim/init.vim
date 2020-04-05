" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" color/theme stuff
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'

" utilities
Plug 'scrooloose/nerdtree' " file explorer
Plug 'Aldlevine/nerdtree-git-plugin' " this fork is required to grey out gitignored files
Plug 'ryanoasis/vim-devicons' " Add file icons to nerdtree, airline, ctrlp etc
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' } " Atom-narrow for vim
Plug 'christoomey/vim-tmux-navigator' " use ctrl-hjkl to navigate between tmux and vim panes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' } " Open markdown files in Marked.app - mapped to <leader>m
Plug 'ap/vim-css-color' " show colors of hex codes etc in editor
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}} " language server protocol support
Plug 'neoclide/coc-denite' " show coc lists in denite interface

" Core utils
Plug 'jeffkreeftmeijer/vim-numbertoggle' " relative/absolute line number management
Plug 'szw/vim-maximizer' " toggle windows fullscreen
Plug 'google/vim-searchindex' " shows number of matches for search commands
Plug 'moll/vim-bbye' " make buffer deleting preserve window layout
Plug 'sickill/vim-pasta' " Context aware pasting (e.g. current indentation)
Plug 'tpope/vim-fugitive' " Git support

" Vim language enhancements
Plug 'tpope/vim-unimpaired' " mappings which are simply short normal mode aliases for commonly used ex commands
Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
Plug 'tpope/vim-commentary' " Adds the operators 'gc' and '[count]gcc' to comment code
Plug 'tpope/vim-repeat' " adds support for the '.' command for vim-surround, vim-commentary and vim-unimpaired
Plug 'kana/vim-textobj-user' " Allows custom text objects
Plug 'kana/vim-textobj-entire' " Adds the text objects 'ie' and 'ae'
Plug 'kana/vim-textobj-fold' " Adds the text objects 'iz' and 'az'
Plug 'kana/vim-textobj-line' " Adds the text objects 'il' and 'al'
Plug 'kana/vim-textobj-function' " Adds the text objects 'if' and 'af'
Plug 'thinca/vim-textobj-function-javascript' " Adds 'if' and 'af' for javascript

" Language specific
Plug 'fatih/vim-go', { 'for': 'go' } " go support
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' } " better syntax highlighting and indenting for haskell
Plug 'elmcast/elm-vim', { 'for': 'elm' } " elm support
Plug 'reasonml-editor/vim-reason', { 'for': 'reason' } " reason support
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'html'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript.jsx', 'javascript'] } " JSX support
" Plug 'styled-components/vim-styled-components', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'javascript', 'javascript.jsx'] } " CSS3 syntax support

call plug#end()

" }}}

" General Setting {{{

" set color themes (from .vim/colors)
syntax enable
execute 'set background='.$BACKGROUND
colorscheme solarized

if has('gui_vimr')
    execute 'set background='.$BACKGROUND
    colorscheme onedark
endif

set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors

" mapleader
let g:mapleader = "\<Space>"

" following 3 lines make the mapleader key work better
set notimeout
set ttimeout
set ttimeoutlen=10

" Use vims old regex engine for faster syntax highlighting
" http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
" set regexpengine=1

" tab control
set smarttab " tab respects 'tabstop', 'shiftwidth and 'softtabstop
set tabstop=4 " set the tab width to 4 spaces
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth
set expandtab " when pressing tab, insert spaces instead

" folds
set foldmethod=indent " default folding based on indentation
set nofoldenable " don't fold by default
set foldlevel=99 " https://stackoverflow.com/a/5786588/2580566

" smarter searching
set ignorecase " case insensitive searching
set smartcase " case sensitive if search term explicilty contains a captital
set incsearch " set incremental search, like modern browsers
set showmatch
set hlsearch " highlight search results
set magic " make searching use normal regex (grep)

" Line number management
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
" NOTE: Focus events don't work inside tmux with neovim
set number relativenumber

" misc
set mouse+=a " lets mouse resize vim windows
if !has('nvim')
    set ttymouse=xterm2 " lets mouse resize vim windows
endif
set linebreak " don't linebreak midword http://vimcasts.org/episodes/soft-wrapping-text/
set noerrorbells "no beeps in vim
set hidden " This allows buffers to be hidden if you've modified a buffer
set noshowcmd   " hide annoying flashing of commands below status bar
set autoindent " keep the indentation on <enter>
set noswapfile   "don't use swapfile
set nobackup     "dont create annoying backup files
set nowritebackup
set encoding=utf-8 " set default encoding to UTF-8
scriptencoding utf-8
set clipboard=unnamed " for copy/paste with osx
" make default splits split below/right instead of above/left
set splitbelow
set splitright
set diffopt+=vertical " always use verical diffs
" show current line number as orange with relativenumber set
hi CursorLineNr ctermfg=3 ctermbg=0
" force vim to read *.md files as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

augroup BufferCheck
    autocmd!
    autocmd  BufEnter * call CheckLeftBuffers()
augroup END

" }}}

" Keymappings {{{

" remap esc
inoremap jk <esc>

" make Y have the same behavior as C and D
nnoremap Y y$

" blackhole register shortcut
nnoremap \ "_

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" will make navigation of wrapped lines worked as you'd expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" faster window splitting
nnoremap <C-s> :split<cr>
nnoremap <C-v> :vsplit<cr>

" edit ~/.config/nvim/init.vim
map <leader>0 :e ~/.config/nvim/init.vim<cr>

" insert empty line between brackets (hacky, need a better way to do this)
inoremap {<CR> {<CR>}<C-o>O

" clear search highlighting and clear any message already displayed
noremap <silent> <leader>/ :set hlsearch! hlsearch?<cr>

" open tags whereever I want
" nnoremap gd <C-]>
" nnoremap gv :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" nnoremap gs :sp <CR>:exec("tag ".expand("<cword>"))<CR>

" buffer navigation
nnoremap <silent> <leader>bp :bprevious<cr> " move to the previous buffer
nnoremap <silent> <leader>bn :bnext<cr> " move to the next buffer
nnoremap <silent> <leader>bc :enew<cr> " Open a new empty buffer
nnoremap <silent> <M-w> :Bdelete<CR> " close current buffer and move to the previous one (i.e. close 'tab' in other editor terminology)
nnoremap <silent> <leader>bq :Bdelete<CR> " close current buffer and move to the previous one (i.e. close 'tab' in other editor terminology)
" nnoremap <silent> <leader>bq :bp <BAR> bd #<CR> " close current buffer and move to the previous one (i.e. close 'tab' in other editor terminology)
nnoremap <silent> <leader>bl <c-^> " toggle between current and previous buffer
" buffer list command/mapping is in CtrlP section

" quick save
nnoremap <silent> <leader>w :w<cr>
" quick save and quit
nnoremap <silent> <leader>x :x<cr>
" quick quit
nnoremap <silent> <leader>q :q<cr>

" toggle relative/absolute line numbers
nnoremap <silent> <leader>. :call NumberToggle()<cr>

" highlight word on double click
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>:CountWord<cr>

" }}}

" Functions {{{

function! NumberToggle()
    if(&relativenumber == 1)
        set number
        set norelativenumber
    else
        set relativenumber
        set number
    endif
endfunc

" https://stackoverflow.com/questions/3431184/highlight-all-occurrence-of-a-selected-word
fun! CountWordFunction()
    try
        let l:win_view = winsaveview()
        let l:old_query = getreg('/')
        let var = expand("<cword>")
        exec "%s/" . var . "//gn"
    finally
        call winrestview(l:win_view)
        call setreg('/', l:old_query)
    endtry
endfun
" Set a command "CountWord" and a mapping to count word
command! -nargs=0 CountWord :call CountWordFunction()

" close Vim if the only buffers left in windows are NERDTree, help, loclist,
" quickfix or terminal
" https://yous.be/2014/11/30/automatically-quit-vim-if-actual-files-are-closed/
function! CheckLeftBuffers()
    if tabpagenr('$') == 1
        let l:i = 1
        while l:i <= winnr('$')
            if getbufvar(winbufnr(l:i), '&buftype') ==# 'help' ||
                        \ getbufvar(winbufnr(l:i), '&buftype') ==# 'quickfix' ||
                        \ getbufvar(winbufnr(l:i), '&buftype') ==# 'terminal' ||
                        \ exists('t:NERDTreeBufName') &&
                        \   bufname(winbufnr(l:i)) == t:NERDTreeBufName
                let l:i += 1
            else
                break
            endif
        endwhile
        if l:i == winnr('$') + 1
            qall
        endif
        unlet l:i
    endif
endfunction

" Trim trailing whitespace
" https://vi.stackexchange.com/a/456
function! TrimTrailingWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunc
" Add command to call this function
command! TrimTrailingWhitespace call TrimTrailingWhitespace()

" Toggle location list (diagnostics)
function! ToggleLocationList()
    let buffer_count_before = s:BufferCount()
    " Location list can't be closed if there's cursor in it, so we need
    " to call lclose twice to move cursor to the main pane
    silent! lclose
    silent! lclose

    if s:BufferCount() == buffer_count_before
        execute "silent! lopen"
    endif
endfunc

function! s:BufferCount()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunc
command! ToggleLocationList call ToggleLocationList()
nnoremap <silent> <leader>d :ToggleLocationList<cr>

" }}}

" Plugins settings {{{

" vim-airline
" -----------
set laststatus=2 " plugin won't work without this line
set noshowmode " hide the default insert/command mode indicator
" let g:airline_powerline_fonts=1 " enable vim-devicons icons in airline

set timeoutlen=20 "gets rid of the pause when leaving insert mode
" for the fonts to work in iTerm, install a patch font and set it in iTerm
" prefs https://github.com/ryanoasis/nerd-fonts
" The line below breaks vimr
" set guifont=Fura\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h14 " won't work in macvim without this line
let g:airline_theme='base16'
" remove the patched arrows
let g:airline_powerline_fonts=0
let g:airline_left_sep=''
let g:airline_right_sep=''

" tabline stuff
let g:airline#extensions#tabline#enabled = 1 " enable the list of buffers at the top of the screen
let g:webdevicons_enable_airline_tabline = 0 " disable vim-devicons in the tabline
let g:airline#extensions#tabline#show_close_button=1 " this doesn't work :(

" buffers to emulate tabs
" let g:airline#extensions#tabline#formatter = 'unique_tail' " show just the filename in the buffer list
" let g:airline#extensions#tabline#fnamemod = ':t' " show just the filename in the buffer list
let g:airline#extensions#tabline#buffer_idx_mode = 1 " show index on buffer tabs
" leader-num to jump to corresponding buffer
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" NERDTree
" --------
" http://www.cheatography.com/stepk/cheat-sheets/vim-nerdtree/

" don't close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0
" show hidden files in NERDTree
let g:NERDTreeShowHidden=1
" change vims cwd when the NERDTree root changes (e.g. when changes bookmark)
let g:NERDTreeChDirMode=2
" Toggle NERDTree
nnoremap <silent> <leader>e :NERDTreeToggle<cr>
" Find current file in NERDTree
nnoremap <silent> <leader>n :NERDTreeFind<cr>
" Shortcut to bring up autocomplete of NERDTree bookmarks
cnoreabbrev b NERDTreeFromBookmark
" remove some files by extension
let g:NERDTreeIgnore = ['\.js.map$', '\.pyc$']
" Change the NERDTree window width (default=31)
let g:NERDTreeWinSize=40
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" remap C-j and C-k commands so it doesnt interfere with vim-tmux-navigator
" plugin
let g:NERDTreeMapJumpNextSibling='C-d'
let g:NERDTreeMapJumpPrevSibling='C-u'
" change window split keys to match ctrlp mappings
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapOpenVSplit='v'
" don't override netrw (this interferes with vim-vinegar)
let g:NERDTreeHijackNetrw=0
" nice alignment of vim-devicons
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0
" Show gitignored status of files (option from nerdtree-git-plugin)
let g:NERDTreeShowIgnoredStatus = 1
" enable showing git status through coloring the text (Aldlevine fork)
let g:NERDTreeGitStatusNodeColorization=1
let g:NERDTreeGitStatusWithFlags = 1

" Change the default colors of git status highlighting to match Atom
hi link NERDTreeGitStatusIgnored Comment
hi link NERDTreeGitStatusModified Type
hi link NERDTreeGitStatusDirDirty Type
hi NERDTreeGitStatusUntracked ctermfg=2 guifg=#98c379
" hi link NERDTreeGitStatusUntracked Operator

" Disable special highlighting of executable file
" https://github.com/scrooloose/nerdtree/blob/8cd17c1a478d8302e4782a95963abe46fc22c538/syntax/nerdtree.vim#L50
hi link NERDTreeExecFile Normal

" CtrlP
" -----
nnoremap <silent> <leader>r :CtrlPMRU<cr>
nnoremap <silent> <leader>bb :CtrlPBuffer<cr>
let g:ctrlp_map='<leader>f'
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'
" use ag for searching instead of vims globpath()
let g:ctrlp_user_command='ag %s -l --nocolor -g ""'

" Fugitive
" --------
" open git status in a new tab
nnoremap <silent> <leader>gs :Gtabedit :<cr>
" Revert current file back to last checked in version - HEAD (:Git checkout %)
nnoremap <silent> <leader>gr :Gread<cr>
" Stage the current file to the index (:Git add %)
nnoremap <silent> <leader>gw :Gwrite<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
nnoremap <silent> <leader>gc :Gcommit<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gl :Glog<cr>

" vim-go
" ------
let g:go_gopls_enabled = 0
" more syntax highlighting for go code
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
" show type info for go code
" let g:go_auto_type_info=1
"  executes :GoFmt everytime a go file is saved, using "goimport" makes saving
"  files slow
let g:go_fmt_command='gofmt'
" disable mappings related to Tags (clashes with <C-t> to open terminal)
let g:go_def_mapping_enabled = 0
" au FileType go nnoremap <Leader>gi :GoImports<cr>
" au FileType go nnoremap <Leader>gm :GoMetaLinter<cr>
" remove red highlighting
let g:go_highlight_trailing_whitespace_error = 0
" run go-metalinter and gofmt on save
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'vetshadow', 'ineffassign', 'goconst']
" gometalinter command when executed via :GoMetaLinter
" au FileType go autocmd BufWritePre * :GoMetaLinter
let g:go_metalinter_command='gometalinter --disable-all --enable=vet
            \ --enable=vetshadow --enable=golint --enable=ineffassign --enable=goconst --enable=gofmt'
" let g:go_metalinter_command="gometalinter --disable=vetshadow --disable=test
"		 \ --disable=testify --disable=errcheck --linter='vet:go tool vet -composites=false ./*.go:PATH:LINE:MESSAGE'"

" vim-marked
" -----------
nnoremap <leader>mo :MarkedOpen<cr>
nnoremap <leader>mq :MarkedQuit<cr>

" vim-jsx
" -------
let g:jsx_ext_required = 0

" vim-maximizer
" -------------
nnoremap <C-w>z :MaximizerToggle<cr>

" elm-vim
" -----------
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0 " disable built-in keybindings
let g:elm_detailed_complete = 1 " show types in autocompletion
" autocomplete only on attributes; doesn't seem to complete local vars
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.elm = '\.'

" coc.nvim
" ========
set signcolumn=yes
hi SignColumn ctermfg=10 ctermbg=0 guifg=Yellow

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :call CocAction('jumpDefinition', 'split')<cr>
nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<cr>
nmap <silent> gt :call CocAction('jumpDefinition', 'tabe')<cr>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Mappings using Denite: https://github.com/neoclide/coc-denite/blob/master/doc/coc-denite.txt
" Show all diagnostics.
nnoremap <silent> <leader>d  :Denite coc-diagnostic<cr>
" Find symbol of current document.
nnoremap <silent> <leader>s  :Denite coc-symbols<cr>
" Search workspace symbols.
command WorkspaceSymbols :Denite coc-workspace

" Golang https://github.com/golang/tools/blob/master/gopls/doc/settings.md for
" settings.json
" format go files on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" vim-surround
" ============
" disable insert mode mappings <c-g>s and <c-g>S
let g:surround_no_insert_mappings=1

" Denite.nvim
" ===========
" https://github.com/Shougo/denite.nvim/issues/652#issuecomment-501747102
" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <c-g>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <esc> <Plug>(denite_filter_quit)
    inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    inoremap <silent><buffer><expr> <c-t>
                \ denite#do_map('do_action', 'tabopen')
    inoremap <silent><buffer><expr> <c-v>
                \ denite#do_map('do_action', 'vsplit')
    inoremap <silent><buffer><expr> <c-s>
                \ denite#do_map('do_action', 'split')
    inoremap <silent><buffer><expr> <C-g>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <C-g>
                \ denite#do_map('quit')
    inoremap <silent><buffer> <C-j>
                \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-k>
                \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

" TODO: get preview working
" nnoremap <leader>l :Denite line -auto-action=preview<cr>
" nnoremap <leader>a :Denite grep -auto-action=preview<cr>
nnoremap <leader>l :Denite line<cr>
nnoremap <leader>a :Denite grep<cr>
" nnoremap <leader>s :Denite outline<cr>
" nnoremap <leader>p :Denite menu:projects -default-action=cd<cr>
nnoremap <leader>p :Denite command -default-action=execute<cr>
" hack fix for terminal vim https://stackoverflow.com/questions/33060569/mapping-command-s-to-w-in-vim
nnoremap <F6> :Denite command -default-action=execute<cr>
" nnoremap <leader>c :Denite file_rec<cr>
" nnoremap <leader>c :Denite file_rec -reversed -winheight=10 -auto-resize<cr>

" highlight groups for matches
hi DeniteHighlightChar ctermfg=4 guifg=Cyan
hi DeniteHighlightRange ctermfg=12 ctermbg=8

" add custom menu for changing projects (cwd)
let s:menus = {}
let s:menus.projects = {
            \ 'description': 'projects'
            \ }

" read in projects.vim file if it exists
" https://stackoverflow.com/questions/19898542/how-to-concatenate-environmental-variables-in-a-vimrc-file
let g:projects_path = $DOTFILES.'/config/nvim/projects.vim'
if filereadable(g:projects_path)
    exec 'source ' . g:projects_path
endif

" if the projects.vim file did exist, set the project list
if exists("g:projects")
    let s:menus.projects.directory_candidates = g:projects
endif

call denite#custom#var('menu', 'menus', s:menus)

" change default options
call denite#custom#option('default', {
            \ 'prompt': '>',
            \ 'start_filter': 1,
            \ 'highlight_matched_char': 'DeniteHighlightChar',
            \ 'highlight_matched_range': 'DeniteHighlightRange'
            \ })


" Change mappings.
" call denite#custom#map(
"             \ 'insert',
"             \ '<C-p>',
"             \ '<denite:do_action:preview>',
"             \ 'noremap'
"             \)
" Ag command on grep source
if executable('ag')
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    " set file_rec to use ag
    call denite#custom#var('file/rec', 'command',
                    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    " call denite#custom#var('file_rec', 'command',
    "             \ ['ag', '-l', '--nocolor', '-g', ''])
endif

" }}}

" GUI settings {{{

" neovim settings
" ===============
if has('nvim')
    " terminal mode
    " -------------------------
    " verical term split, just in case
    nnoremap <silent> <leader>tv :vsp term://$SHELL<cr>
    " nnoremap <silent> <leader>ts :10sp term://$SHELL<cr>

    augroup Term
        autocmd!
        " Always start in terminal mode in term buffers
        autocmd TermOpen * startinsert
        autocmd BufEnter term://* startinsert
        autocmd BufLeave term://* stopinsert
    augroup END

    " escape from terminal mode to normal mode
    tnoremap <esc> <C-\><C-n>

    " window navigation
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l

    tnoremap <C-w>z <C-\><C-n>:MaximizerToggle<cr>i
endif

" vimr settings
" =============
if has('gui_vimr')
    " Fix the airline bar in vimr
    let g:airline_theme='onedark'
    let g:airline_powerline_fonts=0
    let g:airline_left_sep=''
    let g:airline_right_sep=''

    " rerun the last run command https://github.com/kassio/neoterm/issues/81
    nnoremap <silent> <leader>vl :<C-u>exec printf("%sTexec !! \<lt>CR>", v:count)<CR>
    nnoremap <leader>vp :T<space>
endif

" }}}


" vim:foldmethod=marker
