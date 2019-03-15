set nocompatible              " required
filetype off                  " required

syntax enable
set ignorecase

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tmhedberg/SimpylFold'
"Plugin 'aralla/completor.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

Plugin 'git://github.com/edkolev/tmuxline.vim.git'


Plugin 'tell-k/vim-autopep8'


Plugin 'git://github.com/tomasr/molokai.git'
"molokai 主题 monokai的进化版
set t_Co=256
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1


Plugin 'scrooloose/nerdtree'

Plugin 'Xuyuanp/nerdtree-git-plugin'

"Plugin 'Lokaltog/vim-powerline'Valloric/YouCompleteMe'
"Plugin 'maralla/completor.vim'
"Plugin 'scrooloose/syntastic'
"Plugin 'nvie/vim-flake8'
"Plugin 'jnurmine/Zenburn'
"Plugin 'altercation/vim-colors-solarized'

"Plugin 'scrooloose/nerdtree'

"Plugin 'Xuyuanp/nerdtree-git-plugin'

"Plugin 'Lokaltog/vim-powerline'

Plugin 'Yggdroot/indentLine'


Plugin 'kien/ctrlp.vim'

Plugin 'jiangmiao/auto-pairs'

Plugin 'octol/vim-cpp-enhanced-highlight'
"cpp-enhanced-highlight
"高亮类，成员函数，标准库和模板
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
"let g:cpp_experimental_template_highlight = 1

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

let g:completor_python_binary = '/usr/bin/python3.5'
let Tlist_Auto_Highlight_Tag=1
let Tlist_Auto_Open=1
let Tlist_Auto_Update=1
let Tlist_Display_Tag_Scope=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Enable_Dold_Column=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_Use_Right_Window=1
let Tlist_Use_SingleClick=1
nnoremap <silent> <F8> :TlistToggle<CR>

filetype plugin on
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascrīpt set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

let g:pydiction_location='~/.vim/tools/pydiction/complete-dict'
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set number
set lines=35 columns=118


set number "显示行号
set nowrap    "不自动折行
set showmatch    "显示匹配的括号
set scrolloff=3        "距离顶部和底部3行"
set encoding=utf-8  "编码
set fenc=utf-8      "编码
set mouse=n        "启用鼠标
set hlsearch        "搜索高亮

"let python_highlight_all=1
syntax on    "语法高亮


hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h  
\ set tabstop=4   "tab宽度
\ set softtabstop=4 
\ set shiftwidth=4  
\ set textwidth=79  "行最大宽度
"\ set expandtab       "tab替换为空格键
\ set autoindent      "自动缩进
\ set fileformat=unix  "保存文件格式


map <F5> :call RunPython()<CR>
func! RunPython()
    exec "W"
    if &filetype == 'python'
        exec "!time python3.5 %"
    endif
endfunc

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set foldmethod=indent
set foldlevel=99

let g:SimpylFold_docstring_preview=1



au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2
\ set softtabstop=2
\ set shiftwidth=2


au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF


"if has('gui_running')
"  set background=dark
"  colorscheme solarized
"else
"  colorscheme zenburn
"endif

map <C-n> :NERDTreeToggle<CR>

hi MatchParen ctermbg=DarkRed guibg=lightblue


autocmd FileType python noremap <buffer> <F7> :call Autopep8()<CR>


map <F8> :call FormartSrc()<CR>

"定义FormartSrc()
func FormartSrc()
exec "w"
if &filetype == 'c'
exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
elseif &filetype == 'cpp' || &filetype == 'hpp'
exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
elseif &filetype == 'perl'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'py'||&filetype == 'python'
exec "r !autopep8 -i --aggressive %"
elseif &filetype == 'java'
exec "!astyle --style=java --suffix=none %"
elseif &filetype == 'jsp'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'xml'
exec "!astyle --style=gnu --suffix=none %"
endif
exec "e! %"
endfunc
"结束定义FormartSrc
