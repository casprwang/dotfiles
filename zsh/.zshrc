source ~/zsh/path.zsh

export TERM=screen-256color
export VSCODE_TSJS=1

# History
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history     #Where to save history to disk
# #HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
# no duplications in search result
setopt hist_ignore_dups

source ~/zsh/alias.zsh
source ~/zsh/basic.zsh
source ~/zsh/function.zsh
source ~/zsh/github.zsh
source ~/zsh/wifi.zsh
source ~/secrets.zsh

fpath+=~/.zfunc

# Neovim
export EDITOR=nvim
export NVM_LAZY_LOAD=true

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/zsh/fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

### Added by Zplugin's installer
source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin light rupa/z
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
zplugin ice silent wait'!0' atload'load_pyenv;'
zplugin light zdharma/fast-syntax-highlighting
zplugin light lukechilds/zsh-nvm
zplugin light zsh-users/zsh-autosuggestions
zplugin load psprint/zsnapshot
