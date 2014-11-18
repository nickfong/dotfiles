"" begin ~/.vimrc

set background=dark             " Terminal has dark background
set ruler                       " Show info at bottom of screen
set number                      " Line numbers
syntax on                       " Syntax highlighting
" set mouse=a                   " Use the mouse to scroll and Visual/VisLine mode

    " Tab and wrap settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set backspace=indent,eol,start
filetype indent plugin on       " filetype detection[ON] plugin[ON] indent[ON]
set textwidth=80                " Wrap text at 80 chars 

" Usability Settings
set autoread                   " Automatically refresh document has been modified elsewhere (doesn't work)
set nohlsearch                  " Don't continue to highlight searched phrases.
set incsearch                   " But do highlight as you type your search.
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

" Set specific filetypes/indents based on extension
"au BufRead,BufNewFile *.java setl shiftwidth=2 softtabstop=2 tabstop=2
au BufRead,BufNewFile *.java setl shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.c setlocal shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.txt setlocal shiftwidth=2 softtabstop=2 tabstop=2
au BufRead,BufNewFile *.tex setlocal shiftwidth=4 softtabstop=4 tabstop=4
au BufRead,BufNewFile *.py setlocal shiftwidth=4 softtabstop=4 tabstop=4

" Set spell check only for .tex and .txt files
au BufRead,BufNewFile *.txt setlocal spell
au BufRead,BufNewFile *.tex setlocal spell

" Mark Trailing Whitespace as an error
match ErrorMsg '\s\+$'

" Change split mappings to make navigation easier (who needs screen now?)
" <F5> through <F8> resize windows in normal mode
" <F5> and <F8> resize width (HL)
" <F6> and <F7> resize height (JK)
" C-[HJKL] jump between windows in any mode
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
nnoremap <F6> :resize -5 <CR>
nnoremap <F7> :resize +5 <CR>
nnoremap <F5> :vertical resize -5 <CR>
nnoremap <F8> :vertical resize +5 <CR>

set splitbelow              " Split pane opens below the current pane
set splitright              " Split pane opens to the right of current pane

" Git keybindings
" <F2> through <F4> are git commands
nmap <F2> :!git commit -a <CR> 
nmap <F3> :!git pull --rebase <CR> <CR>
nmap <F4> :!git push<CR> <CR>

" Compile keybindings
" <F9> through <F12> compile
nmap <F9> :make <CR><CR>
nmap <F10> :cw <CR>
" nmap <F11> 
nmap <F12> :w <CR> <ESC> :! pdflatex "%"; pdflatex "%"; rm *.aux; rm *.log;<CR><CR>

" Map :Q to :q, :W to :w, and :Wq to :wq
command! Q quit
command! W write
command! Wq wq

"Abbrevations here
"abbreviate [keyword] [expansion]

"" end ~/.vimrc 
