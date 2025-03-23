filetype plugin on
set nocompatible              " be iMproved, required
set encoding=utf8
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
"set guifont=Ubuntu\ Mono\ derivative\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ Plus\ Font\ Awesome\ Plus\ Octicons\ 11
set guifont=Fira\ Code\ 10
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=L
set background=dark
set guicursor=
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

set hidden



call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'rajasegar/vim-pnpm'
" Plug 'neovim/nvim-lspconfig', {'do': 'bash install.sh'}
"Plug 'prettier/vim-prettier', { 'do': 'pnpm install --frozen-lockfile --production' }
Plug 'prettier/vim-prettier', {
  \ 'do': 'pnpm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'github/copilot.vim'
Plug 'sainnhe/everforest'
Plug 'pacha/vem-tabline'
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'sheerun/vim-polyglot'
Plug 'tomlion/vim-solidity'
Plug 'fisadev/vim-isort'
" Plug 'reasonml-editor/vim-reason-plus'
" Plug 'ElmCast/elm-vim'
" Plug 'fatih/vim-hclfmt'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'derekwyatt/vim-scala'
" Plug 'vim-syntastic/syntastic'
" Plug 'ensime/ensime-vim', {'for': 'scala'}
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'sickill/vim-monokai'
" Plug 'w0rp/ale'
Plug 'nordtheme/vim'
" Plug 'davidhalter/jedi'
" Plug 'davidhalter/jedi-vim'
" Plug 'nvie/vim-flake8'
Plug 'junegunn/vim-emoji'
Plug 'ryanoasis/vim-devicons'
" Plug 'elkowar/yuck.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'

call plug#end()
" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'typescript': ['eslint'],
" \   'python': ['ruff'],
" \}
" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️'
" let g:ale_fixers = { "python": ["ruff", "ruff_format"] }
let g:webdevicons_enable_nerdtree = 1
let g:NERDTreeWinSize=60

" nnoremap <localleader>t :EnTypeCheck<CR>
" nnoremap <localleader>T :EnInspectType<CR>
" nnoremap <localleader>p :EnShowPackage<CR>
" nnoremap <localleader>o :EnOrganizeImports<CR>
" autocmd BufWritePost *.scala silent :EnTypeCheck
" au FileType scala nnoremap <localleader>d :EnDeclarationSplit<CR>

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=4 sts=4 sw=4 expandtab listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣ list
autocmd Filetype htmldjango setlocal ts=4 sts=4 sw=4 expandtab listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣ list
autocmd BufNewFile,BufRead *.tag set ft=html

let g:vim_markdown_folding_level = 3
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_folding_disabled = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,.git,*.cache,target
" Ctrl-Space for completions. Heck Yeah!
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>


map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>
map <C-i> :!isort %<CR>:e<CR>
map <C-p> :Files<CR>
map <C-o> :Rg<CR>


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
"inoremap <silent><expr> <CR>coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gk  <Plug>(coc-hover)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> hh :set hlsearch!<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
" colorscheme monokai
colorscheme everforest
"colorscheme solarized
" colorscheme evening
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" check flake8 on save
" autocmd BufWritePost *.py call Flake8()
" let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_javascript_flow_exe = 'flow'
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
set updatetime=250
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

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

let g:coc_global_extensions = [ 'coc-tsserver' ]

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
set guiligatures=!\"#$%&()*+-./:<=>?@[]^_{\|~
if executable('ruff')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ruff',
        \ 'cmd': {server_info->['ruff', 'server']},
        \ 'allowlist': ['python'],
        \ 'workspace_config': {},
        \ })
endif
