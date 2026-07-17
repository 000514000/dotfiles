# 如果存在本机私有配置（例如密钥、代理、机器专属环境变量），先加载它。
# secrets.fish 不应提交到仓库，便于同一份 dotfiles 在多台机器上复用。
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

# 仅在交互式 shell 中启用键位、光标和 fzf 绑定，避免影响脚本执行。
if status is-interactive
    # 使用 Fish 内置的 vi 模式键位。
    fish_vi_key_bindings

    # 为不同 vi 模式设置光标形状，方便快速辨认当前编辑状态。
    set fish_cursor_default block          # 普通模式 (Normal)：方块光标
    set fish_cursor_insert line            # 插入模式 (Insert)：竖线光标
    set fish_cursor_replace_one underscore # 替换模式 (Replace)：下划线光标
    set fish_cursor_visual block           # 视觉模式 (Visual)：方块光标

    # ---- 让 vi 模式的 y / p / P 走系统剪贴板 ----
    # visual 模式下按 y：复制到系统剪贴板，并退回 normal 模式。
    bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    # normal 模式下按 p / P：从系统剪贴板粘贴。
    bind -M default p fish_clipboard_paste
    bind -M default P 'fish_clipboard_paste; commandline -f backward-char'
    # insert 模式下 Ctrl-V 也能从系统剪贴板粘贴。
    bind -M insert \cv fish_clipboard_paste

    # 保持 fzf 键位绑定在 Vim 键位之后加载，确保 Ctrl+R 等快捷键不冲突。
    fzf_key_bindings
end

# 默认编辑器：优先使用 PATH 中找到的 vim。
set -gx EDITOR (command -v vim)
set -gx VISUAL (command -v vim)

# 关闭终端键盘协议功能，避免部分终端或远程环境中出现按键兼容性问题。
set -Ua fish_features no-keyboard-protocols

# 补充常用命令搜索路径。fish_add_path 会去重，重复加载配置也不会无限追加。
fish_add_path /usr/sbin
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/bin

# 常用命令别名。
# 使用 bat 替代 cat，默认不分页且只显示纯文本内容。
alias cat 'bat --paging=never --style="plain"'

# 使用 eza 替代 ls，并统一开启 Git 状态、相对时间和颜色标尺。
alias ls  'eza --git --time-style=relative --color-scale=all'
alias l   'eza --git --time-style=relative --color-scale=all'
alias la  'eza -a --git --time-style=relative --color-scale=all'
alias ll  'eza -l --total-size --git --header --time-style=relative --color-scale=all'
alias lla 'eza -la --total-size --git --header --time-style=relative --color-scale=all'
alias lt  'eza --tree --total-size -l --time-style=relative --color-scale=all'
alias lta 'eza --tree -a --total-size -l --time-style=relative --color-scale=all'

# 快速更新 Debian/Ubuntu 系统包。
alias uu  'sudo apt update && sudo apt full-upgrade -y'
# 快速提交并推送当前 Git 仓库中的所有变更。
alias gg  'git add . && git commit -m "update" && git pull --rebase && git push'
# 生成密码
alias pp  'pwgen -s -y 16 1'

alias ssh="kitty +kitten ssh"

# 启用 starship 提示符。
starship init fish | source


# Added by Antigravity CLI installer
set -gx PATH "/home/tsk/.local/bin" $PATH


# opencode
fish_add_path /home/tsk/.opencode/bin

# >>> grok installer >>>
fish_add_path $HOME/.grok/bin
# <<< grok installer <<<
