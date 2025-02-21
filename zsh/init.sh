# pure
# fpath+=("$(brew --prefix)/share/zsh/site-functions")
# autoload -U promptinit
# promptinit
#
# # optionally define some options
# PURE_CMD_MAX_EXEC_TIME=10
# # change the path color
# zstyle :prompt:pure:path color white
# # change the color for both `prompt:success` and `prompt:error`
# zstyle ':prompt:pure:prompt:*' color cyan
# # turn on git stash status
# zstyle :prompt:pure:git:stash show yes
#
# prompt pure
# end pure

eval "$(starship init zsh)"

export TERM=screen-256color
export VSCODE_TSJS=1

# Neovim
export EDITOR=nvim

# History
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_dups

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey "^B" backward-word
bindkey "^F" forward-word
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^W' backward-kill-word
bindkey '^D' delete-char
