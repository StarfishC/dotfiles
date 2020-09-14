set nocompatible

" vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'liuchengxu/vista.vim'
Plug 'luochen1990/rainbow'
Plug 'tmhedberg/SimpylFold'   "折叠插件
Plug 'Yggdroot/indentLine'
Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons' "图标
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PProvost/vim-ps1'
Plug 'skywind3000/asyncrun.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
" Plug 'voldikss/vim-floaterm'
" Plug 'guns/xterm-color-table.vim'    "配色

call plug#end()            " required



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"split navigations切割窗口
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

inoremap jk <Esc>
inoremap kj <Esc>

inoremap <M-o> <Esc>o
inoremap <M-O> <Esc>O

" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
" 删除当前缓冲区
nnoremap <leader>d :bdelete<CR>
nnoremap <leader>q :nohl<CR>
" colorscheme desert
" colorscheme darkblue
" colorscheme zellner
colorscheme onedark
" set termguicolors
" colorscheme ron
syntax on    "语法高亮
syntax enable
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set relativenumber      "显示行号
set number
set incsearch
set wrap
set showmatch
set scrolloff=3     "距离顶部和底部3行"
set encoding=UTF-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set fenc=UTF-8       "编码
set smartindent
set mouse=a        "启用鼠标
set hlsearch
set linebreak
set t_Co=256
set t_u7=
"set clipboard+=unnamed  "共享系统剪切板
set autoread
set autowrite  "切换buffer时自动保存当前文件
set backspace=2
set ignorecase "搜索时忽略大小写
set smartcase  "如果搜索包含大写字母，不忽略大小写
set expandtab       "tab替换为空格键
set showcmd
set fileformat=unix   "保存文件格式
set foldmethod=syntax
set foldlevel=99
set foldlevelstart=0
set tabstop=4   "tab宽度
set softtabstop=4
set shiftwidth=4
set foldcolumn=0
set fillchars=vert:‖
set cursorline
set wildmenu
set signcolumn=number
highlight cursorLineNr  ctermfg=12
highlight cursorLine    ctermbg=238
highlight Normal        ctermbg=NONE guibg=NONE
highlight SignColumn    ctermbg=NONE guibg=NONE ctermfg=NONE
highlight Comment       ctermbg=NONE ctermfg=117
highlight link CocFloating SignColumn
" highlight Pmenu ctermbg=DarkBlue
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
if has('nvim')
    set guicursor=n-v-c:block,i-ci-ve:hor100,r-cr:hor20,o:hor50,
            \a:blinkwait0-blinkoff400-blinkon250-Cursor/lCursor,
            \sm:block-blinkwait175-blinkoff150-blinkon175
else
    if &term =~ '^xterm'
        " normal mode
        let &t_EI .= "\<Esc>[1 q"
        " insert mode
        let &t_SI .= "\<Esc>[3 q"
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 对于py文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.py
\ set textwidth=79


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 对于c/c++文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.c,*.cpp,*.[ch]
\ set cindent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 对于c/c++文件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.md
\ set textwidth=80


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc-nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has("nvim")
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHold * silent call CocActionAsync('showSignatureHelp')

if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

"补全结束后退出预览窗口
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"使用'[g 和']g跳转诊断出
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gi <Plug>(coc-diagnostic-info)
" highlight link CocErrorSign GruvboxRed

"跳转定义/声明等
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gc <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gl <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"使用K预览窗口显示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" 跳转到第一个浮动窗口
inoremap <leader>aa <plug>(coc-float-jump)

" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

"重命名当前word
nmap <leader>rn <Plug>(coc-rename)

"格式化选中区域
nmap <leader>fs <Plug>(coc-format-selected)
xmap <leader>fs <Plug>(coc-format-selected)
augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)


"跳转下一个代码段占位符
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = "<C-k>"

" show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>"

function! SetupCommandAbbrs(from, to)
    exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

"yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

"enable/disable coc integration >
let g:airline#extensions#coc#enabled = 1
"change error symbol:
let airline#extensions#coc#error_symbol = '😭'
"change warning symbol:
let airline#extensions#coc#warning_symbol = '😱'
"change error format:
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
"change warning format:
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

let g:coc_global_extensions = ['coc-marketplace', 'coc-highlight', 'coc-css', 'coc-python', 'coc-html', 'coc-json',
                            \  'coc-sh', 'coc-snippets', 'coc-tsserver', 'coc-vimlsp', 'coc-yank', "coc-prettier",
                            \  'coc-markdownlint', 'coc-emmet', 'coc-bookmark']

" coc-bookmark
nmap bj <Plug>(coc-bookmark-next)
nmap bk <Plug>(coc-bookmark-prev)
nmap bm <Plug>(coc-bookmark-toggle)
nmap ba <Plug>(coc-bookmark-annotate)

" coc-git
highlight DiffAdd       ctermbg=NONE ctermfg=green
highlight DiffDelete    ctermbg=NONE ctermfg=red
highlight DiffChange    ctermfg=NONE ctermfg=cyan cterm=NONE
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:indentLine_char = '¦'
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 175
autocmd BufNewFile,BufReadPre *.json let g:indentLine_setConceal = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LeaderF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
let g:Lf_WindowHeight = 0.40
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_ShowDevIcons = 1
" let g:Lf_StlColorscheme = 'powerline'
let g:Lf_StlSeparator = { 'left': "\u2b80", 'right': "\u2b82" }
let g:Lf_HideHelp = 1
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline_theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'violet'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline配置:优化vim界面"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#nerdtree_status = 1
let g:airline#extensions#vista#enabled = 1
" 使用powerline打过补丁的字体
let g:airline_powerline_fonts = 1
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" 是否监测空格错误
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '~'
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'conflicts' ]
let g:airline#extensions#whitespace#skip_indent_check_ft = {'markdown': ['trailing']}
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = "🙈"
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vista
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F3> :Vista!!<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"DTree 配置:F2快捷键显示当前目录树
map <F2> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 0 "去除第一行提示
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__$']
let NERDTreeWinSize = 25
let NRRDChristmasTree = 1 "显示增强
let NERDTreeAutoCenter = 1 "自动调整焦点
let NERDTreeHighCursorline = 1  "高亮当前文件
let NERDTreeShowLineNumbers = 1 "显示行号
let NERDTreeShowFiles = 1 "显示文件
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '⇣'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1   "注释自动添加一个空格
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left' "对齐方式
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 1 "允许检查是否注释



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-pairs配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 1
let g:AutoPairsShortcutJump = '<leader>nn'
let g:AutoPairsShortcutBackInsert = '<leader>bb'
let g:AutoPairsMapCR = 1  " 换行并缩进
let g:AutoPairsCenterLine = 1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-devicons
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_startify = 1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SimplyFold配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview=1   "看到折叠代码的文档字符串



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1        "set to 0 if you want to enable it later via :RainbowToggle"
let g:rainbow_conf = {
        \'separately': {
    \       'nerdtree': 0,
    \   }
    \}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>df :Gvdiffsplit<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>oc  <Plug>(easymotion-overwin-f)
nmap <leader>ot  <Plug>(easymotion-overwin-f2)
nmap <leader>ow  <Plug>(easymotion-overwin-w)
nmap <leader>ol  <Plug>(easymotion-overwin-line)



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AsyncRun
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <F6> :call asyncrun#quickfix_toggle(8)<cr>
let g:asyncrun_open = 8
let g:asyncrun_status = ''
" let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown-preview
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sudo ln -s /mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe /usr/bin/edge
" let g:mkdp_browser = 'edge'
let g:mkdp_browser = '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'
let g:mkdp_auto_close = 0
let g:mkdp_page_title = '「${name}」'
nmap <F9> <Plug>MarkdownPreviewToggle



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" c/c++文件表头
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -- New file .h .c .cpp, add file header --
autocmd BufNeWFile *.[ch],*.cpp,*.hpp exec ":call CFileHeader()"
func CFileHeader()
        call setline(1, "// File:    ".strftime(expand('%d')))
        call append(line("."), "// Author:  csh")
        call append(line(".")+1, "// Date:    " .strftime("%Y/%m/%d"))
        call append(line(".")+2, "// ===================")
        call append(line(".")+3, "")
        call append(line(".")+4, "")
        exec "$"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" py文件表头
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -- New file .py, add file header
autocmd BufNeWFile *.py exec ":call PFileHeader()"
func PFileHeader()
        call setline(1, '"""')
        call append(line("."), '@File:    '.strftime(expand('%d')))
        call append(line(".")+1, "@Author:  csh")
        call append(line(".")+2, "@Date:    " .strftime("%Y/%m/%d"))
        call append(line(".")+3, '"""')
        call append(line(".")+4, "")
        call append(line(".")+5, "")
        exec "$"
endfunc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly Run
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :call CompileAndRunCode()<CR>
func! CompileAndRunCode()
    exec "w"
    if &filetype == 'c'
        exec 'AsyncRun! clang % -o a.out; time ./a.out'
    elseif &filetype == 'cpp'
        exec 'AsyncRun! clang++ % -o a.out; time ./a.out'
    elseif &filetype == 'python'
        exec 'AsyncRun! -raw python3 %'
    elseif &filetype == 'sh'
        exec 'AsyncRun! time zsh%'
    endif
endfunc
