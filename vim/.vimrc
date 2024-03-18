" PLUGINS ----------------------------------------- {{{

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'wfxr/minimap.vim'
Plug 'mhinz/vim-startify'
Plug 'github/copilot.vim'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'preservim/tagbar'

if has("persistent_undo")
	let target_path = expand('~/.undodir')

	" create the directory and any parent directories
	" if the location does not exist.
	if !isdirectory(target_path)
		call mkdir(target_path, "p", 0700)
	endif

	let &undodir=target_path
	set undofile
endif

call plug#end()

" }}}

" MAPPINGS --------------------------------------------------------------- {{{
" Use space as leader key
let mapleader = " "
" J and K to move lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Use jk to escape from insert mode
inoremap jk <Esc>

" leader mappings
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>ut :UndotreeToggle<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>m :MinimapToggle<CR>
nnoremap <leader>sr :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nnoremap <leader>t :TagbarToggle<CR>
" no more Q
nnoremap Q <nop>

" Smooth scroll
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 40, 2)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 40, 2)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 40, 4)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 40, 4)<CR>
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
"
" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
	set undodir=~/.vim/backup
	set undofile
	set undoreload=10000
endif

augroup cursor_off
	autocmd!
	autocmd WinLeave * set nocursorline nocursorcolumn
	autocmd WinEnter * set cursorline cursorcolumn
augroup END

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}

" SETTINGS ------------------------------------------------------- {{{

set nocompatible
filetype on
syntax on
set number
set cursorline
set cursorcolumn
set shiftwidth=2
set tabstop=2
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set encoding=UTF-8
set updatetime=300
set signcolumn=yes
set relativenumber
set termguicolors
set scrolloff=8
set updatetime=50
set clipboard=unnamed
colorscheme onedark

let g:lightline = {
			\ 'colorscheme': 'onedark',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'cocstatus': 'coc#status'
			\ },
			\ }

let g:ale_linters = {
			\ 'c': ['clang' , 'gcc'],
			\ 'python': ['mypy'],
			\ 'javascript': ['eslint']
			\ }


" }}}
