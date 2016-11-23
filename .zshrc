export PATH="$PATH:$HOME/.yarn/bin"
export VSCODE_TSJS=1
PATH=$PATH:/usr/local/bin
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
# echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

autoload -U promptinit; promptinit
prompt pure

gitpush() {
    git add .
    git commit -m "$*"
    git push

}
alias gpp=gitpush


alias vimr="vi .vimrc"
alias gs="git status"
alias ga="git add ."
alias gch="git checkout"
alias gcm="git commit -m"
alias gp="git push origin master"
alias gm="git merge"
alias gb="git branch"
alias t="tmux"
alias st="tmux source-file ~/.tmux.conf"
alias tmr="vim .tmux.conf"
alias e="exit"
alias c="clear"
alias ta="tmux a"
alias v="vi"
alias vim="vi"
alias py="python3"
alias o="open"
alias n="node"
alias ip="ipython"
alias p="python3"
alias lsa="ls -a"
alias lsl="ls -lha"
alias bs="bundle exec jekyll serve"
alias co="code"
alias bst="browser-sync start --server --files" 
source /Users/wangsong/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$PATH:$HOME/.yarn/bin"
