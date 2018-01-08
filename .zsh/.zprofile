autoload -Uz compinit
compinit

# autoload -U promptinit; promptinit
# prompt pure
# End of lines added by compinstall
# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export TERM=screen-256color
export VSCODE_TSJS=1
PATH=$PATH:/usr/local/bin

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$PATH:`yarn global bin`"
export PATH="$PATH:$HOME/.yarn/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH=${PATH}:/usr/local/opt/gettext/bin

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin


# for ocaml&&reason
. /Users/song/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval $(opam config env)


export NVIM_TUI_ENABLE_CURSOR_SHAPE=1


export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history     #Where to save history to disk
# #HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# if [ "$PASSWORD" == "$VALID_PASSWORD" ]; then
# 	echo "You have access!"
# else
# 	echo "ACCESS DENIED!"
# fi

source ~/.zsh/alias.zsh
source ~/.zsh/basic.zsh
source ~/.zsh/function.zsh
source ~/.zsh/github.zsh


export PATH="$HOME/.cargo/bin:$PATH"
