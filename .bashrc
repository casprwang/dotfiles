# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# OPAM configuration
. /Users/song/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

eval $(/mnt/truenas/scratch/brewery/bin/brewery --env)
