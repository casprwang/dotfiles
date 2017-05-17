source ~/.zsh/basic.zsh
source ~/.zsh/function.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/github.zsh

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# for ocaml&&reason
. /Users/wangsong/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval $(opam config env)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
