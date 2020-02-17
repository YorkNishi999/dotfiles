let s:dein_dir=expand('~/.vim/dein')
let s:dein_repo_dir=s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible               " Be iMproved
endif

if !isdirectory(s:dein_repo_dir)
  execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif

" Required:
execute 'set runtimepath^=' . s:dein_repo_dir

" Required:
call dein#begin(s:dein_dir)

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neocomplete.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/syntastic')
call dein#add('majutsushi/tagbar')
call dein#add('szw/vim-tags')

" go plugins
call dein#add('fatih/vim-go')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" *******************************************************
" 基本設定
" *******************************************************
" 文字コード
set encoding=utf-8
" 書込文字コード
set fileencoding=utf-8
" 読込文字コード
set fileencodings=utf-8,euc-jp,shift_jis

" 検索
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" 改行で自動的にコメント挿入されるのを防ぐ
autocmd FileType * setlocal formatoptions-=ro

" 構文ハイライト有効
syntax enable

set number
set ruler
set wildmenu
set showmatch
set list
set listchars=tab:>-,extends:<,trail:-,eol:$
set laststatus=2

" change color of listchars such as tab
hi NonText    ctermbg=None ctermfg=59
hi SpecialKey ctermbg=None ctermfg=59

set autoindent
set expandtab

" マウス有効
set mouse=a
set ttymouse=xterm2

set shiftwidth=2
set tabstop=2
set softtabstop=2

set wrap
set whichwrap=h,l,b,s,<,>,[,]
set backspace=indent,eol,start
set title

" Copy/Paste/Cut
set clipboard=unnamed,autoselect

" *******************************************************
" neosnippet
" *******************************************************
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" *******************************************************
" neocomplete
" *******************************************************
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" *******************************************************
" NERDTree
" *******************************************************
" ブックマーク初期表示
let g:NERDTreeShowBookmarks=1
"
let g:NERDTreeChDirMode=2
" windowサイズ設定
let g:NERDTreeWinSize=20
" 表示したくないファイル、ディレクトリ
let g:NERDTreeIgnore=['\.DS_Store$', '\.swp$', '\~$', '\.so']
" vim起動時に常に表示
autocmd vimenter * NERDTree
" NERDTreeだけが残る場合はvim終了
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" *******************************************************
" syntastic
" *******************************************************
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

" *******************************************************
" vim-go
" *******************************************************
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
