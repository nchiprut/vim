" Additional setup:
" sudo apt-get install curl vim exuberant-ctags
" sudo pip install pep8 flake8 pyflakes neovim neovim-remote
" pip install python-language-server
 if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nu
set relativenumber
set hlsearch

let mapleader = ","

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
"Plug 'majutsushi/tagbar'
"Plugin 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'itchyny/lightline.vim'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

call plug#end()

let g:python3_host_prog = '~/sci-env/bin/python'

filetype plugin on
filetype indent on

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
"map <F4> :TagbarToggle<CR>
"" autofocus on tagbar open
"let g:tagbar_autofocus = 1

" ------------------------- Markdown --------------------------
let g:instant_markdown_slow = 1
let g:instant_markdown_python = 1
let g:instant_markdown_browser = "firefox --new-window"

" ------------------------- Vista --------------------------
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc 
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:vista_default_executive = 'coc'
"let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"let g:vista#renderer#enable_icon = 1
"let g:vista_fzf_preview = ['right:50%']
"let g:vista#renderer#icons = {
"\   "function": "\uf794",
"\   "variable": "\uf71b",
"\  }
map <F4> :Vista!!<CR>
" ------------------------- Vimtex --------------------------
"let g:vimtex_compiler_progname = 'nvr'

" ------------------------- Commenter --------------------------

let g:NERDCompactSexyComs = 1

" --------------------------- COC --------------------------
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-python',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-json', 
  \ 'coc-lists', 
  \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
"if has('patch8.1.1068')
  "" Use `complete_info` if your (Neo)Vim version supports it.
  "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
  "imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
"nnoremap <C-]> gd
nmap <C-]> gd
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR><Paste>

" --------------------------- CSCOPE --------------------------
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

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

    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-S-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-S-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-S-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-S-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-S-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-S-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-S-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-S-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>	

    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-S-_>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-S-_>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-S-_>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-S-_>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-S-_>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-S-_>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-S-_>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-S-_>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif
