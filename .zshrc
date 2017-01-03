export PATH=$PATH:/usr/local/go/bin
export TERM=screen-256color
export PATH="$PATH:`yarn global bin`"
export GOPATH=$HOME/gocode
export VSCODE_TSJS=1
PATH=$PATH:/usr/local/bin
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
# echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc


# osascript <<END
#   tell application "Finder"
#     if exists application process "$1" then
#       set visible of application process "$1" to false
#     end if
#   end tell
# END


autoload -U promptinit; promptinit
prompt pure

# quick git add+commit+push
gitpush() {
    git add .
    git commit -m "$*"
    git push
}


gitpush_dotfiles() {
    cd ~/dotfiles
    git add .
    git commit -m "$*"
    git push
    cd -
}

alias babel-node ./node_modules/.bin/babel-node

alias gpp=gitpush
alias gppd=gitpush_dotfiles

# for tmux
alias t="tmux a"
alias tn="tmux new -s"
alias tnew="tmux new -s"
alias tk="tmux kill-server"
# alias vimr="cd ~/dotfiles && nvim nvim/init.vim"
alias vimr="vim ~/.vimrc"
alias nvimr="nvim ~/.config/nvim/init.vim"
# alias zshr="cd ~/dotfiles && nvim .zshrc"
alias so="source"
alias szh="source ~/.zshrc"
alias cdo="cd ~/dotfiles"
alias cno="cd ~/dev/node"
alias czh="v ~/.zshrc"
alias gs="git status"
alias ga="git add ."
alias gch="git checkout"
alias gcm="git commit -m"
alias gp="git push origin master"
alias gm="git merge"
alias gb="git branch"
alias st="tmux source-file ~/.tmux.conf"
alias tmr="nvim ~/.tmux.conf"
alias e="exit"
alias c="clear"
alias ta="tmux a"
alias v="vi"
# alias vim="nvim"
alias py="python3"
alias o="open"
alias n="node"
alias ip="ipython"
alias atom="atom-beta"
# alias p="python3"
alias lsa="ls -a"
alias lsl="ls -lha"
alias bs="bundle exec jekyll serve"
alias co="code"
alias bst="browser-sync start --server --files"
source /Users/wangsong/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$PATH:$HOME/.yarn/bin"

# for docker info below
# https://docs.docker.com/compose/completion/
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# for node projects
export PATH=$PATH:./node_modules/.bin


