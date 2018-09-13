# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export TERM=screen-256color
export VSCODE_TSJS=1
PATH=$PATH:/usr/local/bin

export PATH="$HOME/.cargo/bin:$PATH"

# psql
export PATH="/Library/PostgreSQL/10/bin:$PATH"

export PATH="$PATH:`yarn global bin`"
export PATH="$PATH:$HOME/.yarn/bin"

export PATH=${PATH}:/usr/local/opt/gettext/bin

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin

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

# Setting PATH for Python 3.6
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
