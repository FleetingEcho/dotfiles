# Define essential paths and tools
export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:/Users/tengzhang/.local/bin"

# Environment variables for tools
export BUN_INSTALL="$HOME/.bun"
export EDITOR='nvim'
export GIT_CONFIG_GLOBAL=~/.gitconfig
export LAZYGIT_CONFIG_FILE=~/.config/lazygit/config.yml
export XDG_CONFIG_HOME=~/.config/

# FZF configuration
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Starship configuration
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml

# Initialize plugins and tools
source $ZSH/oh-my-zsh.sh
source /Users/tengzhang/.config/broot/launcher/bash/br
plugins=(
  you-should-use
  gitfast
  zsh-autosuggestions
  zsh-syntax-highlighting
  history-substring-search
)
# not official git clone https://github.com/MichaelAquilina/zsh-you-should-use ~/.oh-my-zsh/custom/plugins/you-should-use


# FZF key bindings
eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FNManager
eval "$(fnm env)"

# Aliases
alias tmux='zellij'
alias lg='lazygit'
alias vim='nvim'
alias vi='nvim'

# Quick navigation aliases
for i in {1..6}; do
  alias cd$i="cd $(printf '../%.0s' $(seq 1 $i))"
done
