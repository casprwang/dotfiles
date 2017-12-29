# setopt -s expand_aliases
alias gp=gitpush
alias gm=go run main.go
alias git=hub
alias mkdi=mkcdir
alias push="git push origin master"
alias cd="cd"
alias gd="gatsby develop"
alias r="fdr"

# showing one level files in the current folder
alias la="ls -1"

# showing files in a tree
alias lt="ls -T"
alias re="cd ~/dev/react"
alias ia="open -a iA\ Writer"
# alias vim=nvim
alias babel-node ./node_modules/.bin/babel-node
alias cdv="cd ~/dev"
alias aria="/usr/local/bin/aria2c"
alias gd="gatsby develop"
alias ag="ag --nobreak --nonumbers --noheading . | fzf"
alias pane="ftpane"
alias sup="cd ~/wangsup"
alias l="exa -1"
alias pretty="find . -name "*.js" | grep -v node_modules | xargs prettier --no-semi --trailing-comma none --write '*.js'"
alias cdg="cd /Users/song/go/src/github.com/wangsongiam/go"
alias cdj="cd ~/dev/javascript"

# for tmux
alias t="tmux a"
# alias cdd="cd ~/dotfiles"
alias sozh="so ~/.zshrc"
alias tn="tmux new -s"
alias tnew="tmux new -s"
alias tk="tmux kill-server"
alias co="cd ~/dev/"

alias ml="ocaml"
# alias vimr="cd ~/dotfiles && nvim nvim/init.vim"
alias vimr="vim ~/.vimrc"
alias nvimr="nvim ~/.config/nvim/init.vim"

# alias zshr="cd ~/dotfiles && nvim .zshrc"
alias rm="trash"
alias zshr="vim ~/.zshrc"
alias so="source"
alias szh="source_zsh"
alias cdo="cd ~/dotfiles"
alias cno="cd ~/dev/node"
alias czh="v ~/.zshrc"
alias push="git push origin master"

# alias eslint="./node_modules/.bin/eslint"
alias gs="git status"
alias ga="git add ."
alias gito="git open"
alias ignore="nvim .gitignore"
alias gch="git checkout"
alias cm="git add .&&git commit"
# alias gp="git push origin master"
# alias gm="git merge"
alias gb="git branch"
alias st="tmux source-file ~/.tmux.conf"
alias xcode="open -a Xcode"

alias tmr="nvim ~/.tmux.conf"
alias cdt="cd ~/temp"
alias cgo="cd ~/gocode/src/github.com/wangsongiam/"
# alias e="exit"
alias jn="jasmine-node"
alias e="fe"
alias ve="fev"
alias c="clear"
alias ta="tmux a"
# alias v="nvim"
# alias vim="nvim"
alias p="python3"
# alias py2="python2"
# alias py3="python3"
alias nr="npm run"
alias read="nvim README.md"
alias g="go run main.go"
alias o="open"
alias n="node"
alias bnode="babel-node"
alias bn="babel-node"
alias ip="ipython"
alias atom="atom-beta"
# alias p="python3"
alias lsa="ls -a"
alias flink="greadlink -f"
alias lsl="ls -lha"
alias bs="bundle exec jekyll serve"
# alias code="code"
alias bst="browser-sync start --server --files"
alias bsb="browser-sync start --server --files ."
alias bst="browser-sync start --server --files"
alias todo="nvim todo.md"

# alias cat=hicat
alias v="nvim"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'

alias show-hidden='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder'
alias hide-hidden='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder'
