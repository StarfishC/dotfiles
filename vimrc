" vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'LunarWatcher/auto-pairs'
Plug 'liuchengxu/vista.vim'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'PProvost/vim-ps1'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'honza/vim-snippets'
Plug 'bfrg/vim-cpp-modern'
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
Plug 'voldikss/LeaderF-floaterm'
Plug 'voldikss/vim-floaterm'
Plug 'caoshenghui/tasksystem'
" Plug 'jackguo380/vim-lsp-cxx-highlight'

call plug#end()            " required



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set autowrite
set backspace=2
set cursorline
"set clipboard+=unnamed  "共享系统剪切板
set encoding=UTF-8
set expandtab       "tab替换为空格键
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set fenc=UTF-8
set fileformat=unix
set foldmethod=indent
set foldlevel=99
set foldlevelstart=0
set fillchars=vert:‖
set hidden
set hlsearch
set incsearch
set ignorecase
set linebreak
set nobackup
set nowritebackup
set nowrap
set number
set mouse=a
set relativenumber
set shortmess+=c
set smartindent
set smartcase
set showmatch
set showcmd
set scrolloff=3     "距离顶部和底部3行"
set softtabstop=4
set shiftwidth=4
set signcolumn=number
set ttimeout
set ttimeoutlen=50
set termencoding=utf-8
set updatetime=250
set wildmenu
colorscheme molokai
let mapleader = " "

"split navigations切割窗口
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
nnoremap <leader>b :bwipe!<CR>
nnoremap <BS> :nohl<CR>
inoremap jk <Esc>
inoremap kj <Esc>
nmap = +

" highlight cursorLineNr  ctermfg=12
" highlight cursorLine    ctermbg=238
" highlight Comment       ctermbg=NONE ctermfg=117
highlight Normal        ctermbg=NONE guibg=NONE
highlight SignColumn    ctermbg=NONE guibg=NONE
highlight LineNr        ctermbg=NONE guibg=NONE
highlight Terminal      ctermbg=NONE guibg=NONE
highlight Pmenu ctermbg=NONE
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

" 移除换行自动注释
au BufNewFile,BufRead * setlocal formatoptions=tcq

" 对于py文件
autocmd BufNewFile,BufRead *.py
\ setlocal textwidth=79

" 对于c/c++文件
autocmd BufNewFile,BufRead *.[ch]pp,*.[ch]
\ setlocal cindent

" 对于md文件
autocmd BufNewFile,BufRead *.md
\ setlocal wrap nofoldenable

" 对于json
autocmd BufNewFile,BufRead *.json
\ setlocal filetype=jsonc syntax=json softtabstop=2

" 对于html
autocmd BufNewFile,BufRead *.html
\ setlocal tabstop=2 softtabstop=2 shiftwidth=2

" 对于quickfix
autocmd FileType qf
\ setlocal norelativenumber



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc-nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" <CR> confirm completion
inoremap <expr> <CR> complete_info()["selected"] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
" trigger completion
if has("nvim")
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

"补全结束后退出预览窗口
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"使用'[d 和']d跳转诊断出
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

"跳转定义/声明等
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gc <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"使用K预览窗口显示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

"重命名当前word
nmap <leader>rn <Plug>(coc-rename)
"openlink
nmap <leader>ol <Plug>(coc-openlink)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

nmap <silent> ,h <Plug>(coc-float-hide)
nmap <silent> ,j <Plug>(coc-float-jump)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
    if !get(b:, 'coc_cursors_activated', 0)
        return "\<Plug>(coc-cursors-word)"
    endif
    return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

"跳转下一个代码段占位符
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = "<C-k>"

" show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<CR>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

function! SetupCommandAbbrs(from, to)
    exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

let g:coc_global_extensions = ['coc-marketplace',
                            \  'coc-highlight',
                            \  'coc-git',
                            \  'coc-pyright',
                            \  'coc-json',
                            \  'coc-sh',
                            \  'coc-snippets',
                            \  'coc-vimlsp',
                            \  'coc-yank',
                            \  'coc-prettier',
                            \  'coc-markdownlint',
                            \  'coc-cmake',
                            \  'coc-explorer',
                            \  'coc-html',
                            \  'coc-htmlhint',
                            \  'coc-emmet',
                            \ ]

" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<CR>

" coc-git
highlight DiffAdd       ctermbg=NONE ctermfg=green cterm=NONE
highlight DiffDelete    ctermbg=NONE ctermfg=red cterm=NONE
highlight DiffChange    ctermbg=NONE ctermfg=cyan cterm=NONE
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap [c <Plug>(coc-git-preconflict)
nmap ]c <Plug>(coc-git-nextconflict)
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>


" windows terminal 插入模式下，ctrl+v Alt+key查看要映射按键
" <M-key> 会导致VIM 插入模式下<ESC>有延迟
" coc-explorer
if has("nvim")
    nnoremap <space>e :CocCommand explorer --position=floating<CR>
    nnoremap <M-e> :CocCommand explorer --position=floating /
else
    nnoremap <space>e :CocCommand explorer<CR>
    nnoremap e :CocCommand explorer /
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:indentLine_char = '¦'
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 175
let g:indentLine_fileTypeExclude = ['coc-explorer', 'help']
autocmd BufNewFile,BufReadPre *.json,*.md let g:indentLine_setConceal = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LeaderF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 使用rg需要安装ripgrep
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fw :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR><CR>
let g:Lf_WindowHeight = 0.40
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_ShowDevIcons = 1
let g:Lf_WorkingDirectoryMode = 'ac'
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
" vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#vista#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '~'
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'conflicts' ]
let g:airline#extensions#whitespace#skip_indent_check_ft = {'markdown': ['trailing']}
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = "💧"
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>= <Plug>AirlineSelectPrevTab
nmap <leader>- <Plug>AirlineSelectNextTab
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = '😡'
let airline#extensions#coc#warning_symbol = '😱'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
let g:airline#extensions#hunks#coc_git = 1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vista
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F3> :Vista!!<CR>
let g:vista_update_on_text_changed = 1
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_echo_cursor_strategy = 'floating_win'
autocmd bufenter * if winnr("$") == 1 && vista#sidebar#IsOpen() | execute "normal! :q!\<CR>" | endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1   "注释自动添加一个空格
let g:NERDDefaultAlign = 'left' "对齐方式
let g:NERDCommentEmptyLines = 0
let g:NERDToggleCheckAllLines = 1 "允许检查是否注释



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-pairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:AutoPairsCompatibleMaps = 0
let g:AutoPairsMapBS = 1
let g:AutoPairsMultilineBackspace = 1
let g:AutoPairsMultilineClose = 1
let g:AutoPairsShortcutToggleMultilineClose = "<c-]>"
let g:AutoPairsShortcutToggle = '\pt'
let g:AutoPairsShortcutJump = '\pj'
let g:AutoPairsShortcutBackInsert = '\pb'
let g:AutoPairsShortcutFastWrap = '\pf'
autocmd FileType markdown let b:AutoPairs = {"$":"$", '(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
autocmd FileType html let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
" 删除右括号
imap <C-x> <Esc>xa



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1        "set to 0 if you want to enable it later via :RainbowToggle"



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gd :Gvdiffsplit<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map  <leader><leader>w <Plug>(easymotion-bd-w)
nmap <leader><leader>w <Plug>(easymotion-overwin-w)
map  <leader><leader>c <Plug>(easymotion-bd-f)
nmap <leader><leader>c <Plug>(easymotion-overwin-f)
nmap <leader><leader>t <Plug>(easymotion-overwin-f2)
map  <leader><leader>l <Plug>(easymotion-bd-jk)
nmap <leader><leader>l <Plug>(easymotion-overwin-line)
autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd   silent! CocEnable



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown-preview
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sudo ln -s /mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe /usr/bin/msedge
" let g:mkdp_browser = 'msedge'
" let g:mkdp_browser = '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'
let g:mkdp_auto_close = 0
let g:mkdp_page_title = '「${name}」'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_conceal = ""
let g:vim_markdown_math = 1



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tasksystem
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tasksystem_usingLeaderF = 1
noremap <leader>fr :Leaderf --nowrap task<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" floaterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:floaterm_autoclose = 1
let g:floaterm_keymap_new  = '<C-t>'
let g:floaterm_keymap_prev = '<C-p>'
let g:floaterm_keymap_next = '<C-n>'
let g:floaterm_keymap_kill = '<C-q>'
let g:floaterm_keymap_toggle = '<F6>'
nnoremap <leader>ft :Leaderf --nowrap floaterm<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly Run
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delete win
tnoremap <silent> <F4> <C-\><C-n>:FloatermKill!<CR>
noremap <silent> <F4> :call OpenCloseWin()<CR>
function! OpenCloseWin()
    let winlist = []
    let wininfo = getwininfo()            " vim支持term_list
    for win in wininfo
        if win['terminal'] || win['quickfix']
            call add(winlist, win['bufnr'])
        endif
    endfor
    if winlist != []
        for i in winlist
            exec 'bwipe! ' . i
        endfor
    else
        exec "copen"
    endif
endfunction
" terminal
tnoremap <silent> <F5> <C-\><C-n>:FloatermKill<CR> :call CompileAndRunCode()<CR>
noremap <silent> <F5> :call CompileAndRunCode()<CR>
function! CompileAndRunCode()
    exec 'Tasksystem quick-run'
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 退出VIM时关闭quickfix和terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * call ExitVim()
function! ExitVim()
    let wininfo = getwininfo()
    let close = 1
    for win in wininfo
        if !win['terminal'] && !win['quickfix']
            let close = 0
            break
        endif
    endfor
    if close == 1
        exec 'qall!'
    endif
endfunction
