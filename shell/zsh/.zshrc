# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# Set to superior editing mode

set -o vi

export VISUAL=nvim
export EDITOR=nvim

# Directories

export REPOS="$HOME/repos"
export GITUSER="alexyz205"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export XDG_CONFIG_HOME="$HOME/.config"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

path=(
    $path                           # Keep existing PATH entries
    $HOME/bin
    $HOME/.local/bin
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# ~~~~~~~~~~~~~~~ Load plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  echo "Starship not found, skipping initialization."
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
else
  echo "zoxide not found, skipping initialization."
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
else
  echo "fzf not found, skipping fzf initialization."
fi

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ~~~~~~~~~~~~~~~ Configurations ~~~~~~~~~~~~~~~~~

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt hist_ignore_space

# completion using arrow keys (based on history)
bindkey '^[[1;5A' history-search-backward
bindkey '^[[1;5B' history-search-forward

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
alias c="clear"

# Repos

alias dot='cd $REPOS/dotfiles'
alias repos='cd $REPOS'

# ls

alias ls='ls --color=auto'
alias la='ls -lathr'

alias t='tmux'
alias e='exit'

# Git

alias gp='git pull'
alias gs='git status'
alias lg='lazygit'
alias ld='lazydocker'

# Devpod

alias ds='devpod ssh'

# Docker
alias dru='docker run -it --rm -v ~/repos/dotfiles:/root/dotfiles ubuntu bash'

# Nix
alias nr='nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/repos/dotfiles/nix#Alexis-MBA'

# SSH
alias sshhs='ssh alexyz@homeserveralexyz'
