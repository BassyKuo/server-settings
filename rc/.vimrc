" Modified: 2018/02/26
" [reference]
" http://amix.dk/vim/vimrc.html

" Runtime Path Manipulation 
execute pathogen#infect()

set t_Co=256
set encoding=utf-8
set fileencodings=utf-8,cp950
"set ffs=unix,dox,mac
filetype plugin on
"filetype plugin on
"filetype indent on	" set this and `set nosi` if smartindent doesnot work

set bg=dark
"colorscheme onehalfdark
"let g:airline_theme='onehalfdark'
" lightline
"let g:lightline.colorscheme='onehalfdark'

syntax enable 
set nocompatible
set ci	" c indent
set ai	" auto indent
set si	" smart indent
" helper for indent mistake
"set list listchars=tab:»·,trail:·

set wrap	" wrap the line when words in one line too much
"set paste	" enable paste on gui (CRTL + v)
set shiftwidth=4
set tabstop=4
set softtabstop=4
" set noexpandtab
set expandtab	" [tab] ==> [space]
				" You also can set `:retab` to use \s instead of \t in 
				" whole file, or `:.retab` in one line

set nu
set relativenumber
set ruler
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expression turn magic on
set magic

set ic	" search ignore Upper/Lower-case (`:set ignorcase`)
set smartcase
set hlsearch
set incsearch
set wrapscan
"set smartindent
set cindent
set confirm
set history=100
set cursorline
set cursorcolumn

" Folding
"set foldenable
"set foldmethod=indent
"set foldcolumn=1
"set foldlevel=5


" auto add comment
set formatoptions+=r

" Key Mapping
"inoremap ( ()<ESC>i
"inoremap " ""<ESC>i
"inoremap ' ''<ESC>i
"inoremap [ []<ESC>i
"inoremap {<CR> {<CR>}<ESC>ko

"if exists('+cursorline')
"	set cursorline cursorcolumn
"endif

" Set extra options when running in GUI mode
if has("gui_runnning")
	set guioptions-=T
	set guioptions+=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

""" NERDTree Plugin """
" NERDTree autorun when vim starts:
"autocmd vimenter * NERDTree
autocmd FileType nerdtree set norelativenumber nonu
autocmd FileType nerdtree set nocursorcolumn
let NERDTreeWinPos = 'right'
let NERDTreeWinSize = '25'
"let NERDTreeDirArrowExpandable = '*'
"let NERDTreeDirArrowCollapsible = '*'
let NERDTreeShowHidden = 1	" <NERDTree-I>
let NERDTreeShowLineNumbers = 0
let NERDTreeHighlightCursorline = 0
nnoremap <silent> <F5> :NERDTreeToggle<CR>
map <NERDTree-t> :NERDTreeMapOpenInTab NERDTreeMirror
map <NERDTree-T> :NERDTreeMapOpenInTabSilent NERDTreeMirror
""" auto close the file + NERDTree_table if the file is a final one opening:
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"""

""" Taglist Plugin """
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Inc_Winwidth = 0
let Tlist_Exit_OnlyWindow = 1
nnoremap <silent> <F4> :TlistToggle<CR>
autocmd FileType taglist set norelativenumber nonu
autocmd FileType taglist set nocursorcolumn

" Normal-mode Remap
nnoremap \ :set nocursorline nocursorcolumn<CR>
nnoremap = :set cursorline cursorcolumn<CR>
nnoremap <space> :noh<CR>
nnoremap <silent> - yypVr-

" Visual-mode Remap
vnoremap <silent> <space> :g/^ *$/d<CR>:noh<CR>

" Insert-mode Remap
"inoremap <F5> <ESC>yyp<C-v>$r-A


" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"map <silent> 8 :norm i//<ESC>:noh<CR>gm
"map <silent> 9 :s#\v//(.*)#\1#g<CR>:noh<CR>
"exe \"<silent> map <C-.>".g:comment." 0<C-v>I".g:comment."<ESC>:noh<CR>gm"
"exe \"<silent> map <C-.>.".key." :s#\v".key."(.*)#\1#g<CR>:noh<CR>"
nmap <silent> <C-c>	\c
xmap <silent> <C-c>	\c


"map <C-t> :tabnew<cr>
"map <C-w> :tabclose<cr>

"nmap <C-b>n  :bnext<CR>
"nmap <C-b>p  :bprev<CR>

"set laststatus=2
"set statusline=%4*%<\%m%<[%f\%r%h%w]\ [%{&ff},%{&fileencoding},%Y]%=\[Position=%l,%v,%p%%]

" Color configuration
color afterglow " Same as `:colorscheme elflord`
"color dracula
"color dark_eyes
"set bg=dark		" light/dark
"hi Folded    guifg=#708090 guibg=#c0d0e0
hi Folded    guifg=#a0a0a0 guibg=#e8e8e8 gui=italic
hi Folded    cterm=NONE ctermfg=45 ctermbg=239
hi DiffChange cterm=NONE ctermfg=130 ctermbg=236
"hi DiffText cterm=bold ctermfg=11 ctermbg=160
hi DiffText cterm=bold ctermfg=yellow ctermbg=6

hi Normal cterm=NONE ctermfg=Grey ctermbg=NONE
hi Number cterm=NONE ctermfg=205
hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
hi CursorLine gui=underline guifg=NONE guibg=DarkGrey
hi CursorColumn cterm=NONE ctermfg=None ctermbg=darkgrey
"hi CursorLineNr cterm=bold ctermfg=Red ctermbg=NONE
hi LineNr cterm=bold ctermfg=Grey ctermbg=NONE guifg=#AAAAAA
"hi Keyword cterm=underline ctermfg=RED ctermbg=NONE
hi Comment cterm=NONE ctermfg=DarkCyan ctermbg=NONE


"--------Color Name--------
" NR-16	NR-8	<NAME>
"   0	 0		Black
"   1	 4		DarkBlue
"   2	 2		DarkGreen
"   3	 6		DarkCyan
"   4	 1		DarkRed
"   5	 5		DarkMagenta
"   6	 3		DarkYellow, Brown
"   7	 7		LightGray, LightGrey, Gray, Grey
"   8	 0*		DarkGray, DarkGrey
"   9	 4*		Blue, LightBlue
"  10	 2*		Green, LightGreen
"  11	 6*		Cyan, LightCyan
"  12	 1*		Red, LightRed
"  13	 5*		Magenta, LightMagenta
"  14	 3*		Yellow, LightYellow
"  15	 7*		White
"---------256 Color---------
"https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg

""""" If you want to refresh '.vimrc', use `so[urce] %` or `so $MYVIMRC` """""
""""" which '%' means 'this file'.          ^^^^^^^^^^      ^^^^^^^^^^^
