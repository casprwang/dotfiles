# vi mode
bindkey -v
export KEYTIMEOUT=1

# Neovim
export EDITOR=nvim

# History
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history     #Where to save history to disk
setopt appendhistory     #Append history to the history file (no overwriting)
setopt sharehistory      #Share history across terminals
setopt incappendhistory  #Immediately append to the history file, not just when a term is killed
setopt hist_ignore_dups

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey "^B" backward-char
bindkey "^F" forward-char
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^D' delete-char

