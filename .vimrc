"" begin ~/.vimrc 

set background=dark       " Terminal has dark background
set ruler                 " Show info at bottom of screen
set number                " Line numbers
syntax on                 " Syntax highlighting
" set mouse=a              " Use the mouse to scroll and Visual/VisLine mode

" Tab and wrap settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set backspace=indent,eol,start
filetype indent plugin on " filetype detection[ON] plugin[ON] indent[ON]
set textwidth=80          " Wrap text at 80 chars 
"set autoread              " Automatically refresh document has been modified elsewhere (doesn't work)
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set hid                   " A buffer becomes hidden when it is abandoned
set ignorecase            " Ignore case when searching
set expandtab             " Use spaces instead of tabs
set smarttab              " Be smart when using tabs

" Set specific filetypes/indents based on extension
"au BufRead,BufNewFile *.java setl shiftwidth=2 softtabstop=2 tabstop=2
au BufRead,BufNewFile *.java setl shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.c setlocal shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.txt setlocal shiftwidth=2 softtabstop=2 tabstop=2

map <F1> dd
map <F2> d$
map <F3> dw
map <F5> :!git add -u <CR> <CR>
map <F6> :!git commit <CR>
map <F7> :!git push github master<CR>
map <F9> :wq
"map <F10> :w<CR>
"map <F11> :w <CR> <ESC> :make <CR>
"map <F11> :w <CR> <ESC> :set makeprg=javac\ %<CR>:make<CR>
"map <F12> :!echo %\|awk -F. '{print $1}'\|xargs java<CR>
map <F12> :w <CR> <ESC> :! pdflatex "%"; pdflatex "%"; rm *.aux; rm *.log;<CR><CR>

"Map :Q to :q, :W to :w, and :Wq to :wq
command! Q quit
command! W write
command! Wq wq

"Abbrevations here
"abbreviate [keyword] [expansion]

"" end ~/.vimrc 
