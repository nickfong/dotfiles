"" begin ~/.vimrc


let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

set timeoutlen=100              " Compromise between airline and leader timeout

scriptencoding utf-8
set encoding=utf-8
set t_Co=256

let mapleader = "\<Space>"      " Set Leader to be a space
set background=dark             " Terminal has dark background
set ruler                       " Show info at bottom of screen
set number                      " Line numbers
syntax on                       " Syntax highlighting
set mouse=nicr                  " Hacky way to avoid resizing windows with scroll wheel
colorscheme molokai

" Tab and wrap settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set backspace=indent,eol,start
filetype indent plugin on       " filetype detection[ON] plugin[ON] indent[ON]
set textwidth=80                " Wrap text at 80 chars

" Usability Settings
set autoread                    " Automatically refresh document has been modified elsewhere (doesn't work)
set nohlsearch                  " Don't continue to highlight searched phrases
set incsearch                   " But do highlight as search is typed
set hid                         " A buffer becomes hidden when it is abandoned
set ignorecase                  " Ignore case when searching
set expandtab                   " Use spaces instead of tabs
set smarttab                    " Be smart when using tabs
set showcmd                     " Show information about current command (e.g. number of selected lines)
set confirm                     " Ask if changes should be saved
set pastetoggle=<F12>           " Toggle paste:nopaste with <F12> when in insert mode
set laststatus=2                " Persistent line status at bottom of screen
set wildmenu                    " Enable menu at bottom of screen
set wildmode=list:longest,full  " Show list of completions, longest common completed, then wildmenu
set cursorline                  " Display a line beneath the cursor's current line
set nowrap                      " Let lines trail off the edge of the terminal without wrapping

set printoptions=paper:letter,duplex:on

" Highlight the 81st column if applicable
highlight ColorColumn ctermbg=blue
call matchadd('ColorColumn', '\%81v', 100)

"set swapfile                    " Set a swapfile
"set dir=~/tmp                   " But have it write to ~/tmp instead of the current working directory

" Filetype-specific settings
au BufRead,BufNewFile *.java setl shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.c setlocal shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.txt setlocal shiftwidth=2 softtabstop=2 tabstop=2
au BufRead,BufNewFile *.tex setlocal shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.py setlocal shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.rb setlocal shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.yml  setlocal shiftwidth=2 softtabstop=2 tabstop=2
au BufNewFile,BufRead *.coffee set filetype=javascript
au BufNewFile,BufRead *.cls set filetype=plaintex
au BufRead,BufNewFile *.json set filetype=json
autocmd Filetype gitcommit setlocal spell textwidth=72

" Set automatic enabling of spell check only for .tex, .txt, and .md files
au BufRead,BufNewFile *.txt setlocal spell
au BufRead,BufNewFile *.tex setlocal spell
au BufRead,BufNewFile *.md setlocal spell

" Mark Trailing Whitespace as an error
match ErrorMsg '\s\+$'

" Highlight last inserted text
nnoremap gV `[v`]

" Change split mappings to make navigation easier (who needs screen now?)
" Arrow keys resize windows (up arrow increases height, down decreases, right
" arrow increases width, left decreases)
" C-[HJKL] jump between windows in any mode
noremap <C-j> <C-W><C-J>
noremap <C-k> <C-W><C-K>
noremap <C-l> <C-W><C-L>
noremap <C-h> <C-W><C-H>
nnoremap <down> :resize -5 <CR>
nnoremap <up> :resize +5 <CR>
nnoremap <left> :vertical resize -5 <CR>
nnoremap <Right> :vertical resize +5 <CR>

set splitbelow              " Split pane opens below the current pane
set splitright              " Split pane opens to the right of current pane

" Git keybindings
" <F2> through <F4> are git commands
nnoremap <F1> :!git diff<CR>
nnoremap <F2> :!git commit -a <CR>
nnoremap <F3> :!git pull --rebase <CR> <CR>:e<CR><CR>
nnoremap <F4> :!git push<CR> <CR>

" Toggle relative or absolute line numbers with Control-n
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Miscellaneous Keybindings
" Toggle text wrap
nnoremap <F5> :set wrap! wrap?<cr>
" Remove trailing whitespace
nnoremap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <F7> :if exists("syntax_on") \| syntax off \| else \| syntax on \| endif \|<cr><C-g>
"nooremap <F7> :call ToggleNumber()
"nooremap <F7> :set norelativenumber<CR>

" Compile keybindings
" TODO:  Move these to ~/.vim/ftplugin/<filetype>_mappings.vim
nnoremap <F9> :make <CR><CR>
nnoremap <F10> :cw <CR>

" Insert Debug Statement
autocmd Filetype python nnoremap <F8> oimport pdb; pdb.set_trace()<ESC> :w<CR>
autocmd Filetype python nnoremap <F9> ggVG:s/^.*import pdb; pdb.set_trace()\n//<CR>

" Lint
autocmd Filetype python nnoremap <F11> :w <CR> <ESC> :! pylint "%"<CR>
autocmd Filetype json nnoremap <F11> :w <CR> <ESC> :! python -m json.tool "%"<CR>

" Build
autocmd Filetype python nnoremap <F12> :w <CR> <ESC> :! python "%"<CR>
autocmd Filetype tex nnoremap <F12> :w <CR> <ESC> :! pdflatex "%"; pdflatex "%"; rm *.aux; rm *.log;<CR><CR>

" Map :Q to :q, :W to :w, and :Wq to :wq, ignore q: typo
command! Q quit
command! W write
command! Wq wq
map q: :q

nnoremap - <NOP>

" Add python/bash/ruby comments faster
" Also: block --> I --> # --> Esc
vnoremap # :s#^#\##<cr>
" Also: block --> x
vnoremap -# :s#^\###<cr>
" Same thing for LaTeX
vnoremap % :s%^%\%%<cr>
vnoremap -% :s%^\%%%<cr>

" Enable j/k in long lines
map j gj
map k gk

" Map H to BOL and L to EOL
nnoremap H 0
nnoremap L $
" Leader-Related Shortcuts

" Automatically remove trailing whitespace before saving
"autocmd FileType c,java,rb,tex,feature,txt,py,html,css autocmd BufWritePre <buffer> :%s/\s\+$//e
" autocmd BufWritePre <buffer> :%s/\s\+$//e
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
" Show tabs in file so they can be expunged
set list listchars=tab:»·,trail:·

" Make saving and quitting faster
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :wq<CR>

" Use the system clipboard for copying and pasting by prefixing with Leader
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" Delete
nnoremap <Leader>d dd

" Duplicate line
nnoremap <Leader>j Vyp

" Pair completion for curly braces
"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
"inoremap {}     {}

" Pair completion for parens
"inoremap (      ()<Left>

" Automatically reload .vimrc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"Abbrevations here
"abbreviate [keyword] [expansion]

"" end ~/.vimrc
