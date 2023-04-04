vim9script
# vim-Plug
var path = has("win32") ? '~/vimfiles/plugged' : '~/.vim/plugged'
plug#begin(path)

Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'LunarWatcher/auto-pairs'
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
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
Plug 'voldikss/LeaderF-floaterm'
Plug 'voldikss/vim-floaterm'
Plug 'caoshenghui/vim-tasks'

plug#end()


#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# 通用配置
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set autoread
set autowrite
set cursorline
set clipboard+=unnamed
set expandtab
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set fenc=UTF-8
set nofoldenable
set backspace=2
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
set scrolloff=3
set tabstop=4
set softtabstop=4
set shiftwidth=4
set signcolumn=yes
set ttimeout
set ttimeoutlen=50
set termencoding=utf-8
set updatetime=250
set wildmenu
set sessionoptions+=globals
set termguicolors
colorscheme sonokai

highlight cursorLineNr  cterm=NONE
highlight Search        cterm=bold ctermfg=16 ctermbg=76 gui=bold guifg=#292b2e guibg=#86dc2f
highlight Normal        ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
highlight SignColumn    ctermbg=NONE guibg=NONE
# highlight Terminal      ctermbg=NONE guibg=NONE
highlight CocInlayHint  cterm=Italic ctermfg=12 gui=Italic guifg=#15aabf
highlight EndOfBuffer   ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
highlight CocHighlightText ctermfg=223 ctermbg=239 guifg=#ebdbb2 guibg=#242a32

if has("gui_running")
    g:floaterm_shell = "pwsh.exe"
    set background=dark
    set guioptions-=L
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guifont=JetBrainsMono_Nerd_Font_Mono:h12:W500:cANSI:qDRAFT
endif

g:mapleader = " "
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

if &term =~ '^xterm'
    # normal mode
    &t_EI ..= "\<Esc>[1 q"
    # insert mode
    &t_SI ..= "\<Esc>[3 q"
endif

if system("uname -r") =~ "microsoft"
    augroup Yank
        autocmd!
        autocmd TextYankPost * : call system('clip.exe', @")
    augroup END
endif

# 移除换行自动注释
au BufNewFile,BufRead * setlocal formatoptions=tcq

# 对于py文件
autocmd BufNewFile,BufRead *.py
\ setlocal textwidth=79

# 对于c/c++文件
autocmd BufNewFile,BufRead *.[ch]pp,*.[ch]
\ setlocal cindent

# 对于md文件
autocmd BufNewFile,BufRead *.md
\ setlocal wrap nofoldenable tabstop=2 softtabstop=2 shiftwidth=2

# 对于json
autocmd BufNewFile,BufRead *.json
\ setlocal filetype=jsonc syntax=json tabstop=2 softtabstop=2 shiftwidth=2

# 对于html
autocmd BufNewFile,BufRead *.html
\ setlocal tabstop=2 softtabstop=2 shiftwidth=2

# 对于quickfix
autocmd FileType qf
\ setlocal norelativenumber

autocmd BufNewFile,BufRead *.tsl,*.tsf setf tsl



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# coc-nvim
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
def Check_back_space(): bool
    var col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
enddef
inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ <SID>Check_back_space() ? "\<TAB>" :
        \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
# <CR> confirm completion
inoremap <silent><expr><CR> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm()
                            \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
# trigger completion
inoremap <silent><expr> <c-@> coc#refresh()

# 补全结束后退出预览窗口
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
# 使用'[d 和']d跳转诊断出
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

# 跳转定义/声明等
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gc <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

# 使用K预览窗口显示文档
nnoremap <silent> K :call <SID>Show_documentation()<CR>
def Show_documentation(): void
    if g:CocAction('hasProvider', 'hover')
        g:CocActionAsync('doHover')
    else
        feedkeys('K', 'in')
    endif
enddef

# Applying codeAction to the selected region.
# Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
# Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
# Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

# 重命名当前word
nmap <leader>rn <Plug>(coc-rename)
# openlink
nmap <leader>ol <Plug>(coc-openlink)

# Use <TAB> for selections ranges.
# NOTE: Requires 'textDocument/selectionRange' support from the language server.
# coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

nmap <silent> ,h <Plug>(coc-float-hide)
nmap <silent> ,j <Plug>(coc-float-jump)

nmap ,cl <Plug>(coc-codelens-action)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <expr> <silent> <C-d> <SID>Select_current_word()
def Select_current_word(): string
    if !get(b:, 'coc_cursors_activated', 0)
        return "\<Plug>(coc-cursors-word)"
    endif
    return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
enddef

autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
    autocmd!
    # Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    # Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

# Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

# 跳转下一个代码段占位符
g:coc_snippet_next = '<C-j>'
g:coc_snippet_prev = "<C-k>"

nnoremap <silent> <space>d  :<C-u>CocList diagnostics<CR>
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

def SetupCommandAbbrs(from: string, to: string): void
    exec 'cnoreabbrev <expr> ' .. from
        \ .. ' ((getcmdtype() ==# ":" && getcmdline() ==# "' .. from .. '")'
        \ .. ' ? ("' .. to .. '") : ("' ..  from .. '"))'
enddef
# Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

def ToggleOutline(): void
    var winid = coc#window#find('cocViewId', 'OUTLINE')
    if winid == -1
        g:CocActionAsync('showOutline', 1)
    else
        g:coc#window#close(winid)
    endif
enddef
nnoremap <silent><nowait> <space>o  :call <SID>ToggleOutline()<CR>


# Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
# Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocActionAsync('fold', <f-args>)
# Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

g:coc_global_extensions = ['coc-marketplace',
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
                            \  'coc-clangd',
                            \ ]

# coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<CR>

# coc-git
highlight DiffAdd       ctermbg=NONE ctermfg=green cterm=NONE
highlight DiffDelete    ctermbg=NONE ctermfg=red cterm=NONE
highlight DiffChange    ctermbg=NONE ctermfg=cyan cterm=NONE
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap [c <Plug>(coc-git-preconflict)
nmap ]c <Plug>(coc-git-nextconflict)
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>


# windows terminal 插入模式下，ctrl+v Alt+key查看要映射按键
# <M-key> 会导致VIM 插入模式下<ESC>有延迟
# coc-explorer
nnoremap <space>e :CocCommand explorer<CR>
nnoremap e :CocCommand explorer /



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# indentLine
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
g:indentLine_enabled = 1
g:indentLine_char_list = ['|', '¦', '┆', '┊']
# g:indentLine_color_term = 175
g:indentLine_fileTypeExclude = ['coc-explorer', 'help', 'startify', 'coctree']
g:vim_json_conceal = 0
g:markdown_syntax_conceal = 0


#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# LeaderF
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# 使用rg需要安装ripgrep
g:Lf_UseCache = 0
g:Lf_HideHelp = 1
g:Lf_ShortcutF = "<leader>ff"
g:Lf_WindowHeight = 0.40
g:Lf_WindowPosition = 'popup'
g:Lf_PreviewInPopup = 1
g:Lf_ShowDevIcons = 1
g:Lf_IngoreCurrentBufferName = 1
g:Lf_WorkingDirectoryMode = 'ac'
g:Lf_StlColorscheme = 'powerline'
g:Lf_StlSeparator = { 'left': "\u2b80", 'right': "\u2b82" }
g:Lf_WildIgnore = {
            \ 'dir': ['.svn', '.git', '.hg'],
            \ 'file': ['*.sw?', '~$*', '*.bak', '*.exe', '*.o', '*.so', '*.py[co]']
            \}
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fw :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
noremap <leader>fg :<C-U>Leaderf! rg --recall<CR>
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR><CR>



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# vim-airline
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
g:airline_experimental = 1
# g:airline_powerline_fonts = 1
g:airline#extensions#tabline#enabled = 1
g:airline#extensions#tabline#buffer_nr_show = 0
g:airline#extensions#tabline#show_tab_count = 1
g:airline#extensions#tabline#show_tab_type = 1
g:airline#extensions#tabline#formatter = 'unique_tail_improved'
g:airline#extensions#whitespace#enabled = 1
g:airline#extensions#whitespace#symbol = '~'
g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'conflicts' ]
g:airline#extensions#whitespace#skip_indent_check_ft = {'markdown': ['trailing']}
g:airline#extensions#tabline#buffer_idx_mode = 1
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
g:airline#extensions#coc#enabled = 1
g:airline#extensions#coc#show_coc_status = 1
g:airline#extensions#coc#error_symbol = '😡'
g:airline#extensions#coc#warning_symbol = '😱'
g:airline#extensions#hunks#coc_git = 1



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# nerdcommenter
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
g:NERDSpaceDelims = 1
g:NERDDefaultAlign = 'left'
g:NERDCommentEmptyLines = 0
g:NERDToggleCheckAllLines = 1
g:NERDCustomDelimiters = {'tsf': {'left': '//', 'right': ''}}



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# auto-pairs
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
g:AutoPairsCompatibleMaps = 0
g:AutoPairsMapBS = 1
g:AutoPairsMultilineBackspace = 1
g:AutoPairsMultilineClose = 1
g:AutoPairsShortcutToggle = '\pt'
g:AutoPairsShortcutJump = '\pj'
g:AutoPairsShortcutBackInsert = '\pb'
g:AutoPairsShortcutFastWrap = '\pf'
# 删除右括号
imap <C-x> <Esc>xa



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# rainbow
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
g:rainbow_active = 1



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# vim-fugitive
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gd :Gvdiffsplit<CR>



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# easymotion
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map  <leader><leader>w <Plug>(easymotion-bd-w)
nmap <leader><leader>w <Plug>(easymotion-overwin-w)
map  <leader><leader>c <Plug>(easymotion-bd-f)
nmap <leader><leader>c <Plug>(easymotion-overwin-f)
nmap <leader><leader>t <Plug>(easymotion-overwin-f2)
map  <leader><leader>l <Plug>(easymotion-bd-jk)
nmap <leader><leader>l <Plug>(easymotion-overwin-line)
autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd   silent! CocEnable



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# markdown-preview
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# sudo ln -s /mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe /usr/bin/msedge
# let g:mkdp_browser = 'msedge'
# let g:mkdp_browser = '/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'
g:mkdp_auto_close = 0
g:mkdp_page_title = '「${name}」'



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# vim-markdown
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
g:tex_conceal = ""
g:vim_markdown_math = 1



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# vim-tasks
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
g:Tasks_UsingLeaderF = 1
noremap <leader>fr :Leaderf --nowrap task<CR>



#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# floaterm
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
g:floaterm_autoclose = 1
g:floaterm_keymap_new  = '<C-t>'
g:floaterm_keymap_prev = '<C-p>'
g:floaterm_keymap_next = '<C-n>'
g:floaterm_keymap_kill = '<C-q>'
g:floaterm_keymap_toggle = '<F6>'
hi FloatermBorder ctermfg = cyan
nnoremap <leader>ft :Leaderf --nowrap floaterm<CR>



#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Quickly Run
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# delete win
def OpenCloseWin(): void
    var winlist = []
    var wininfo = getwininfo()
    for win in wininfo
        if win['terminal'] || win['quickfix']
            add(winlist, win['bufnr'])
        endif
    endfor
    if winlist != []
        for i in winlist
            exec 'bwipe! ' .. i
        endfor
    else
        exec "copen"
    endif
enddef
tnoremap <silent> <F4> <C-\><C-n>:FloatermKill!<CR>
noremap <silent> <F4> :call <SID>OpenCloseWin()<CR>
# terminal
def CompileAndRunCode(): void
    exec 'TaskRun quick-run'
enddef
tnoremap <silent> <F5> <C-\><C-n>:FloatermHide<CR> :call <SID>CompileAndRunCode()<CR>
noremap <silent> <F5> :call <SID>CompileAndRunCode()<CR>



#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# 退出VIM时关闭quickfix和terminal
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * call ExitVim()
def ExitVim(): void
    if winnr('$') == 1 && &filetype == 'startify'
        execute "qall!"
    elseif winnr('$') == 1 && has("gui_running") && &filetype == ''
        execute "Startify"
    else
        var wininfo = getwininfo()
        var ftlist = ["terminal", "quickfix", "coc-explorer", "coctree"]
        var close = 1
        for win in wininfo
            var ft = getwinvar(win['winid'], '&filetype')
            if index(ftlist, ft) < 0
                close = 0
                break
            endif
        endfor
        if close == 1
            if has("gui_running")
                execute "bufdo bd"
                execute "Startify"
            else
                execute "qall!"
            endif
        endif
    endif
enddef

