" RATIONAL {{{
"  -'Leader' is associated with function calls
"  -'Ctrl' is associated with movements and text manipulation
"  -'g' is alias to 'go to'
"
" Interesting:
"
"   [[   - go to next tag (function)
"   {    - go to next paragraph
"   (    - go to next sentence
"   ]s   - go to next SpellBad
"   %    - go to matching (
"
"   z=   - open spelling suggestion
"
"   gf   - opens file under cursor
"   gd   - goes to var definition ( similar to # / * )
"   g;   - navigates jump history forward
"   g,   - navigates jump history back
"   gi   - jump to last edit
"   gcc  - comment line
"   gqq  - hard wrap line
"   gwip - join lines in paragraph
"   dgn  - delete next match, gn does action in next hlsearch
"
" Surround
"   ds[  - delete surrounding '['
"   cs[( - change surrounding '[' to '('
"   ys<move><addition>
"   on visual mode -- S(char)
"
"   <C-w>r swap splits
"
"   :windo diffthis
"   :windo diffoff
"   :diffupdate
"
"   :changes
"   :%retab
"
"   :%s//string/g
"   :%s/pattern//gn
"
"   :g/pattern/y A
"   :g/pattern/d
"   :g!/pattern/d or :v/pattern/d
"   :g/pattern/t$
"   :g/pattern/m$
"   :g/^pattern/s/$/string
"   :g/pattern/normal 100^A
"   :g/pattern1/g/pattern2/d
"   better search g/PATTERN/#
"
"   q{register}q - clean register
"   "{register upper case}y{move} - append to register
"   m{register upper case} - for moving between files
"  }}}

" PLUGINS {{{

    call plug#begin('~/.vim/plugged')

    " if has('nvim')
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " else
    " Plug 'Shougo/deoplete.nvim'
    " Plug 'roxma/nvim-yarp'
    " Plug 'roxma/vim-hug-neovim-rpc'
    " endif

    Plug 'ambv/black', { 'on': 'Black' }
    Plug 'dense-analysis/ale'
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
    Plug 'luochen1990/rainbow'
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'Yggdroot/indentLine'

" Color schemes
    Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
    Plug 'junegunn/seoul256.vim'
    Plug 'morhetz/gruvbox'
    Plug 'liuchengxu/space-vim-dark'

    call plug#end()
"}}}

" COLOR  {{{

    if has('termguicolors')
        set termguicolors
    endif

    set background=dark
    set laststatus=2
    set noruler

    " colorscheme space-vim-dark
    colorscheme seoul256
    let g:lightline = { 'colorscheme': 'seoul256'}

    nnoremap <F5> :colorscheme gruvbox<CR>
    nnoremap <F6> :colorscheme seoul256<CR>
    nnoremap <F7> :colorscheme space-vim-dark<CR>
    nnoremap <F8> :colorscheme challenger_deep<CR>
"}}}

" SET DEFAULTS {{{

    filetype plugin indent on

    set autoread
    set cursorline
    set foldmethod=manual
    set hlsearch
    set list
    set listchars=eol:¬
    set nocompatible
    set noincsearch
    set nowrap
    set number relativenumber
    set pastetoggle=<F2>
    set shiftround
    set showcmd
    set showmatch
    set smarttab
    set splitright splitbelow
    set title
    set undolevels=100
    set virtualedit=block
    " set backspace=indent,eol,start

" No Swap file
    set noswapfile
    set nobackup
    set nowb

" Go to normal mode quicker
    set ttimeout
    set ttimeoutlen=100

" Following python.org
    syntax on
    set encoding=utf-8
    set expandtab
    set fileformat=unix
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4

" Provides tab-completion for all file-related tasks
    set path+=**
    set wildmenu
"}}}

" KEY MAPS {{{

    let mapleader=','

" Better
    nnoremap Y y$
    nnoremap H ^
    nnoremap L g_
    vnoremap H ^
    vnoremap L g_

    nnoremap <C-d> <C-d>zz
    nnoremap <C-u> <C-u>zz
    " Intel model M workaround
    nnoremap <A--> <C-d>zz
    nnoremap <A-=> <C-u>zz

    nnoremap U <C-r>
    nnoremap <CR> o<Esc>
    nnoremap viz v[zo]z$

    " better to use gi or g, g;
    " nnoremap g. `.
    " nnoremap g, ``
    " nnoremap gu guiw
    " nnoremap gU gUiw
    nnoremap gV `[v`]

    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>/ :nohlsearch<CR>
    nnoremap <Leader>g :Goyo<CR>
    nnoremap <Leader>b !!bash<CR>
    nnoremap <Leader>t :NERDTreeToggle<CR>
    nnoremap <Leader>w :call ToggleWrap()<CR>
    nnoremap <Leader>s :call ToggleSpell_EN()<CR>
    nnoremap <Leader>S :call ToggleSpell_PT()<CR>
    nnoremap <Leader>n :call ToggleNumber()<CR>

" Change keyboard layout
    nnoremap <F3> :!kb_us<CR>
    nnoremap <F4> :!kb_br<CR>

" Navigation in buffers
    nnoremap <Tab> :bn<CR>
    nnoremap <S-Tab> :bp<CR>

" Terminal mode
    if has('nvim')
        tnoremap <Esc> <C-\><C-n>
        tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
        nnoremap <Leader>T :vsp term://bash<CR>
    endif

" Quality of life
    noremap ; :
    noremap : ;
    cnoremap ; :
    cnoremap : ;

" Swap v and CTRL-V
    nnoremap    v   <C-V>
    nnoremap <C-V>     v
    vnoremap    v   <C-V>
    vnoremap <C-V>     v

" Completion
    inoremap <C-f> <C-x><C-f>
    inoremap <C-p> <C-x><C-p>
    inoremap <C-n> <C-x>s
    inoremap <C-r> <C-r>"

" Keep selection after indenting
    xnoremap <silent> < <gv
    xnoremap <silent> > >gv

" Bash like
    cnoremap <C-a> <home>
    cnoremap <C-e> <end>

" Slip windows
    nnoremap <Up> <C-w><Up>
    nnoremap <Down> <C-w><Down>
    nnoremap <Left> <C-w><Left>
    nnoremap <Right> <C-w><Right>

    nnoremap <C-Up> <C-w>+
    nnoremap <C-Down> <C-w>-
    nnoremap <C-Left> <C-w><
    nnoremap <C-Right> <C-w>>

" Useless keys
    " nnoremap s <NOP>
    " nnoremap S <NOP>
    nnoremap K <NOP>
    nnoremap M <NOP>
    nnoremap Q <NOP>
    nnoremap gQ <NOP>
    nnoremap ^ <NOP>
    nnoremap _ <NOP>
    nnoremap g_ <NOP>
    nnoremap <Space> <NOP>
    nnoremap <Del> <NOP>
    nnoremap <Backspace> <NOP>
"}}}

" MISC {{{

" Change default vim register
    set clipboard=unnamed
    if has('unnamedplus')
      set clipboard=unnamed,unnamedplus
    endif

" Highlight Column
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)

" Disables automatic commenting on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace on save
    autocmd BufWritePre * %s/\s\+$//e
"}}}

" FUNCTIONS {{{

" Highlight the match in red
    function! HLNext (blinktime)
        highlight WhiteOnRed ctermfg=white ctermbg=red
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#\%('.@/.'\)'
        let ring = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        call matchdelete(ring)
        redraw
    endfunction

    nnoremap <silent> n   n:call HLNext(0.6)<CR>
    nnoremap <silent> N   N:call HLNext(0.6)<CR>

" Toggle between number and relativenumber
    function! ToggleNumber()
         if(&relativenumber == 1)
             set norelativenumber
             set number
         else
             set relativenumber
    endif
    endfunction

" Toggle spellcheck (EN)
    function! ToggleSpell_EN()
         if(&spell == 1)
             set nospell
         else
            set spell spelllang=en_us
            highlight SpellBad ctermbg=Blue
    endif
    endfunction

" Toggle spellcheck (PT)
    function! ToggleSpell_PT()
         if(&spell == 1)
             set nospell
         else
            set spell spelllang=pt
            highlight SpellBad ctermbg=Blue
    endif
    endfunction

    set nospell
    set complete+=kspell

" Toggle wrap line
    function! ToggleWrap()
         if(&wrap == 1)
             set nowrap
         else
             set wrap linebreak nolist
    endif
    endfunction

" Count unique words in visual selection
    function! UniqueWords()
        silent '<,'>w !tr -cd "[:alpha:][:space:]-/'" |
        \ tr ' [:upper:]' '\n[:lower:]' |
        \ tr -s '\n' |
        \ sed "s/^['-]*//;s/['-]$//" | sort |
        \ uniq -c | sort -nr > /tmp/unique_vim
    endfunction
"}}}

" PLUGINS {{{

    " let g:deoplete#enable_at_startup = 1
    set statusline+=%{FugitiveStatusline()}

" Ale
    " let g:ale_fix_on_save=1
    let g:ale_lint_on_enter=0
    let g:ale_lint_on_text_changed='never'
    let python_highlight_all=1

    " set statusline+=%#warningmsg#
    " set statusline+=%*

" Black
    let g:black_skip_string_normalization=1

" Open NERDTree automatically when vim starts up on a directory
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Rainbow parentheses
    let g:rainbow_active = 1
"}}}

" FILES {{{

    autocmd FileType vim set foldmethod=marker
    autocmd FileType c nnoremap <Leader>c :w<CR> :!gcc % -lm -o %< && ./%<<CR>

" Python
    autocmd FileType python,sh,c set foldmethod=indent
    autocmd FileType python,sh,c set foldlevel=99
    autocmd FileType python,sh,c set autoindent

    autocmd FileType python nnoremap <Leader>c :w<CR> :!python %<CR>
    autocmd FileType python nnoremap <Leader>C :w<CR> :r !python %<CR>
    autocmd FileType python inoremap ; :
    autocmd FileType python inoremap : ;

    if has('python3')
        autocmd BufWritePre *.py execute ':Black'
    endif

" Latex Files
    autocmd FileType tex,plaintex,markdown nnoremap j gjzz
    autocmd FileType tex,plaintex,markdown nnoremap k gkzz

    autocmd FileType tex,plaintex nnoremap <Leader>c :w! \| :!pdflatex -interaction=nonstopmode %<CR><CR>
    autocmd FileType tex,plaintex,markdown vnoremap <Leader>u
                \:call UniqueWords()<CR>:vsp /tmp/unique_vim \| vertical resize 30 \| w<CR>
"}}}
