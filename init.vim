" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|


" Author: @Alkaido
" Checkout-list
" vim-esearch
" fmoralesc/worldslice
" SidOfc/mkdx

" ===
" === Auto load for first time uses
" ===


" ===
" === Vim
" ===
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===
" === Neovim
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


set nu
set encoding=utf-8  
set termencoding=utf-8   
set fileencodings=ucs-bom,utf-8,chinese   
set langmenu=zh_CN.utf-8  
set tabstop=4
set shiftwidth=4
autocmd BufWritePost $MYVIMRC source $MYVIMRC
set helplang=cn
set encoding=utf-8
filetype plugin indent on
set nobackup            " 设置不备份
set noswapfile          " 禁止生成临时文件
set wildmenu             " 开启zsh支持
set wildmode=full        " zsh补全菜单
set so=5
set cuc
set cul
set rnu

map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>


source $HOME/.config/nvim/config/plug.vim
source $HOME/.config/nvim/config/coc.nvim
source $HOME/.config/nvim/config/nert-tree.vim

"colorscheme molokai
colorscheme tokyonight


" c/c++
" F10编译和运行C程序，C++程序,Python程序，shell程序，F9 gdb调试
" 请注意，下述代码在windows下使用会报错，需要去掉./这两个字符
 
" <F10> 编译和运行C
noremap <F10> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<.out"
		:set splitright
		:vsp
		:term ./%:r.out
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "markdown-preview-enhanced.openPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc


" ===markdownpreview
let g:mkdp_markdown_css=''
let g:vim_markdown_math = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_browser = "chromium"
let g:vim_markdown_folding_disabled = 1



inoremap <silent><expr> <c-e>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<c-e>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
