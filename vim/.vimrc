" 启用 Vim 语法高亮，让代码和配置文件更容易阅读。
syntax on

" 在普通模式下按 Ctrl+p 调用 FZF 文件搜索。
" 需要系统或插件管理器已安装 FZF，否则按下快捷键时会提示命令不存在。
nnoremap <C-p> :FZF<CR>

" 关闭交换文件，避免在目录中生成 .swp 临时文件。
set noswapfile

" 关闭普通备份文件，避免保存后生成以 ~ 结尾的备份文件。
set nobackup

" 关闭写入备份文件，避免保存过程中生成临时备份文件。
set nowritebackup

" 使用系统剪贴板，方便在 Vim 和其他应用之间复制粘贴。
set clipboard=unnamedplus

" 将 Tab 键转换为空格，避免文件中混入制表符。
set expandtab

" 按下 Tab 键时插入 4 个空格。
set tabstop=4
set softtabstop=4

" 自动缩进时使用 4 个空格的宽度。
set shiftwidth=4

" 在每行左侧显示行号，方便定位和跳转。
set number

" 显示相对行号：当前行为绝对行号，其余行显示与当前行的距离，方便 5j、3k 等跳转。
set relativenumber

let mapleader = ","

nmap <leader>y <Plug>OSCYankOperator
nmap <leader>yy <leader>y_
vmap <leader>y <Plug>OSCYankVisual
