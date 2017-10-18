set nocompatible              " be iMproved, required
set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
set background=dark
set guicursor=

call plug#begin('~/.vim/plugged')

Plug 'fisadev/vim-isort'
Plug 'ElmCast/elm-vim'
Plug 'fatih/vim-hclfmt'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'derekwyatt/vim-scala'
Plug 'vim-syntastic/syntastic'
Plug 'ensime/ensime-vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sickill/vim-monokai'
Plug 'davidhalter/jedi'
Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8'
Plug 'junegunn/vim-emoji'
Plug 'ryanoasis/vim-devicons'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'

call plug#end()

let g:webdevicons_enable_nerdtree = 1
filetype plugin indent on    " required
nnoremap <localleader>t :EnTypeCheck<CR>
nnoremap <localleader>T :EnInspectType<CR>
nnoremap <localleader>p :EnShowPackage<CR>
nnoremap <localleader>o :EnOrganizeImports<CR>
autocmd BufWritePost *.scala silent :EnTypeCheck
au FileType scala nnoremap <localleader>d :EnDeclarationSplit<CR>

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2


set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,.git,*.cache,target
" Ctrl-Space for completions. Heck Yeah!
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>


map <C-n> :NERDTreeToggle<CR>
" map <C-m> :NERDTreeFind<CR>
map <C-p> :Files<CR>
set nu
set omnifunc=syntaxcomplete#Complete
autocmd BufNewFile,BufRead *.scala   set ft=scala " Set syntax highlighting for .scala files
autocmd BufNewFile,BufRead *.sc      set ft=scala " Set syntax highlighting for scala worksheet files
autocmd BufNewFile,BufRead *.sbt      set ft=scala " Set syntax highlighting for scala worksheet files

" set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
let g:airline_powerline_fonts = 1

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)

set t_Co=256

set history=100
syntax enable
colorscheme monokai
"colorscheme solarized
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" check flake8 on save
autocmd BufWritePost *.py call Flake8()
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_javascript_flow_exe = 'flow'
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
set updatetime=250

" sudo apt-get install ttf-ancient-fonts
let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_modified_removed = emoji#for('collision')
set pastetoggle=<F3>
set clipboard=unnamed
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
set updatetime=250

" sudo apt-get install ttf-ancient-fonts
let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_modified_removed = emoji#for('collision')
let ensime_server_v2=1

" let g:vim_isort_python_version = 'python3'

