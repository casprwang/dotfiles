source ~/.zsh/basic.zsh
source ~/.zsh/function.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/fzf.zsh

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


" for ocaml&&reason
. /Users/wangsong/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval $(opam config env)
