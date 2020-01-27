# Path
source ~/zsh/path.zsh

export TERM=screen-256color
export VSCODE_TSJS=1

# Neovim
export EDITOR=nvim
export NVM_LAZY_LOAD=true

# History
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt appendhistory     #Append history to the history file (no overwriting)
setopt sharehistory      #Share history across terminals
setopt incappendhistory  #Immediately append to the history file, not just when a term is killed
setopt hist_ignore_dups
