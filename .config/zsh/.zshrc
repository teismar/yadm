# ZSH
setopt CORRECT
setopt CORRECT_ALL

# Paths & Variables
path+=($HOME/.local/bin)
export PATH

export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Source custom scripts
for file in "$ZDOTDIR/scripts/"*.zsh; do
  [ -r "$file" ] && source "$file"
done
# source antidote
source "$HOME/.antidote/antidote.zsh"

# FPATH
fpath+=("$ZDOTDIR/functions")

# Load completions
autoload -Uz compinit && compinit

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# History
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory # share history between sessions
setopt hist_ignore_space # commands starting with a space will be ignored
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias cat='bat'

# Shell integrations
eval "$(fzf --zsh)" # newer fzf needed
# Enable fuzzy auto-completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable key bindings
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh

eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# Jump into tmux
#if [ -z "$TMUX" ]
#then
#    tmux attach -t TMUX || tmux new -s TMUX
#fi

