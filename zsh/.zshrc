setopt auto_cd

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
HISTFILE=~/.zsh_history     #Where to save history to disk
setopt appendhistory     #Append history to the history file (no overwriting)
setopt sharehistory      #Share history across terminals
setopt incappendhistory  #Immediately append to the history file, not just when a term is killed
setopt hist_ignore_dups

source ~/zsh/alias.zsh
source ~/zsh/keymap.zsh
source ~/zsh/function.zsh
source ~/zsh/github.zsh
source ~/zsh/wifi.zsh
source ~/zsh/aws.zsh
source ~/zsh/vi-mode.zsh
source ~/secrets.zsh
source ~/zsh/fzf.zsh

# Zplugin
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light rupa/z
zinit ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
zinit ice silent wait'!0' atload'load_pyenv;'
zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma/zsh-diff-so-fancy
zinit light zdharma/fast-syntax-highlighting
zinit light lukechilds/zsh-nvm
zinit light zsh-users/zsh-autosuggestions
zinit load psprint/zsnapshot
