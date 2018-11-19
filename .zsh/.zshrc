# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export TERM=screen-256color
export VSCODE_TSJS=1
PATH=$PATH:/usr/local/bin

export PATH="$HOME/.cargo/bin:$PATH"

# psql
export PATH="/Library/PostgreSQL/10/bin:$PATH"

export PATH=${PATH}:/usr/local/opt/gettext/bin

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# mac port
export PATH=$PATH:/opt/local/bin

# export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history     #Where to save history to disk
# #HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
# no duplications in search result
setopt hist_ignore_dups

source ~/.zsh/alias.zsh
source ~/.zsh/basic.zsh
source ~/.zsh/function.zsh
source ~/.zsh/github.zsh

fpath+=~/.zfunc

export EDITOR=nvim

export NVM_LAZY_LOAD=true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.zsh/fzf.zsh

### Added by Zplugin's installer
source '/Users/song/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin ice silent wait'!0' atload'load_pyenv'
zplugin light rupa/z
## Load the pure theme, with zsh-async that's bundled with it
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

zplugin ice silent wait"!0"
zplugin light zdharma/fast-syntax-highlighting
zplugin light lukechilds/zsh-nvm

zplugin ice silent wait'!0' atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions
zplugin load psprint/zsnapshot

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/song/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/song/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/song/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/song/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

eval $(/Users/song/.brewery/bin/brewery --env)
