" Minimal Neovim Configuration
" Primarily using VS Code and IntelliJ, Neovim for quick terminal editing

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Color theme
Plug 'joshdick/onedark.vim'

" Core utilities
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-highlightedyank'

call plug#end()
" }}}

" General Settings {{{
syntax enable
set background=dark
try
  colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

if (has("termguicolors"))
    set termguicolors
endif

" Leader key
let g:mapleader = "\<Space>"
set ttimeout
set ttimeoutlen=10

" Tab settings
set expandtab
set shiftwidth=2
set softtabstop=2
set smarttab

" Search settings
set ignorecase
set smartcase
set incsearch
set hlsearch

" Display
set number
set relativenumber
set linebreak
set wrap
set breakindent
set mouse=a

" Behavior
set hidden
set splitbelow
set splitright
set fileformats=unix,dos,mac
set completeopt=menuone,noselect

" Files
set swapfile
set nobackup
set nowritebackup
" }}}

" Keybindings {{{
" Escape
inoremap jk <esc>

" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>a :Rg<CR>

" Git
nnoremap <silent> <leader>gs :G<cr>
nnoremap <silent> <leader>gd :Gdiffsplit<cr>
nnoremap <silent> <leader>gp :Git push<cr>

" Utils
nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>q :q<cr>
nnoremap <silent> <leader>/ :set hlsearch!<cr>
" }}}

" FZF Settings {{{
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:fzf_enter() abort
  let b:fzf_laststatus = &laststatus
  let b:fzf_showmode = &showmode
  let b:fzf_ruler = &ruler
  set laststatus=0 noshowmode noruler
endfunction

function! s:fzf_leave() abort
  if exists('b:fzf_laststatus')
    let &laststatus = b:fzf_laststatus
    unlet b:fzf_laststatus
  endif
  if exists('b:fzf_showmode')
    let &showmode = b:fzf_showmode
    unlet b:fzf_showmode
  endif
  if exists('b:fzf_ruler')
    let &ruler = b:fzf_ruler
    unlet b:fzf_ruler
  endif
endfunction

augroup fzf_layout
  autocmd!
  autocmd FileType fzf call <SID>fzf_enter() |
    \ autocmd BufLeave <buffer> call <SID>fzf_leave()
augroup END
" }}}

" vim:foldmethod=marker
