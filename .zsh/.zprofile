export PATH="$HOME/.cargo/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# export GOPATH=$HOME/dev/go
# export PATH=$PATH:$(go env GOPATH)/bin
# export GOPATH=$(go env GOPATH)
# export GOROOT=$HOME/dev/go

# fpath=(~/.zsh/completions $fpath) 
# autoload -U compinit && compinit

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# for ocaml&&reason
. /Users/song/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval $(opam config env)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



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
