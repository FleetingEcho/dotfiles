set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH


switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end


# 设置 PATH 路径
set -gx PATH $HOME/bin /usr/local/bin $PATH

set -gx ZSH "$HOME/.oh-my-zsh"

# 使用 Starship 作为提示符
if test -f "$HOME/.config/starship.toml"
    starship init fish | source
end

# 别名和插件加载
alias vim='nvim'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'

# 设置 Bun 和 Volta 环境变量
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH $VOLTA_HOME/bin $PATH

# 设置其他路径
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH /opt/homebrew/opt/postgresql@15/bin $PATH
set -gx PATH /usr/local/opt/python@3.11/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx EDITOR "code"

# Bun 环境变量
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH


# fzf 设置
if type -q fzf
    set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"
end

# Rye 环境
set -gx PATH $HOME/.rye/bin $PATH

# broot 启动器
alias br="broot"


# fzf 自定义生成器（Fish 不支持直接重写 `_fzf_compgen_path`）
function fzf_compgen_path
    fd --hidden --exclude .git . "$argv[1]"
end

function fzf_compgen_dir
    fd --type=d --hidden --exclude .git . "$argv[1]"
end


# 历史记录子字符串搜索（Fish 支持相似功能）
# Fish 已经自带类似功能

if test -f ~/.fzf.fish
    source ~/.fzf.fish
end
