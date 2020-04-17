" Additional setup:
" sudo apt-get install curl vim exuberant-ctags
" sudo pip install pep8 flake8 pyflakes neovim neovim-remote
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nu
set relativenumber
set hlsearch

:let mapleader = ","

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

set nocompatible              " be iMproved, required

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'


call plug#end()

let g:python3_host_prog = '~/.venv/bin/python'
filetype plugin indent on
filetype plugin on
filetype indent on

syntax enable
set background=dark
colorscheme gruvbox

nmap  <C-Left> :bprevious<CR>
nmap <C-Right>   :bnext<CR>
nmap  <C-Up> :cprevious<CR>
nmap <C-Down>   :cnext<CR>
nmap <S-Down> :w<CR>G:r !gcc % -o %< && ./%<<CR>

" ----------------------- Trailing whitespace -----------------------
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" ------------------------- Terminal --------------------------
if has('nvim')
    tnoremap <c-w> <c-\><c-n><c-w>
endif
" ------------------------- Tagbar --------------------------
" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" ------------------------- Gutentag --------------------------
let g:gutentags_project_root = ['.root', '.git']
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" enable gtags module
let g:gutentags_modules = ['ctags', 'cscope']

"let g:gutentags_auto_add_cscope = 1
let g:gutentags_cscope_build_inverted_index = 1
let g:gutentags_file_list_command = {
 \ 'markers': {
     \ '.git': 'git ls-files',
     \ '.root':'find . -type f',
     \ },
 \ }

" --------------------------- CSCOPE --------------------------
if has("cscope")

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    "if filereadable("cscope.out")
        "cs add cscope.out
    " else add the database pointed to by environment variable
    "elseif $CSCOPE_DB != ""
        "cs add $CSCOPE_DB
    "endif

    " show msg when any other cscope db added
    set cscopeverbose
    " multiple choices as quickfix
    set cscopequickfix=s-,c-,d-,i-,t-,e-

    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " Hitting CTRL-space before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-space>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-space>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-space>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-space>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-space>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-space>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-space>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-space>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif
