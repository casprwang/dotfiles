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

# git setup
gitsetup() {
  git init
  git remote add origin $1
  git pull --rebase origin master
  git add .
  git commit -m "🎉 rebase"
  git push origin master
}


# quick git add+commit+push
gitpush() {
    git add .
    git commit -m "$*"
    git push origin master
}
alias gp=gitpush


# quick git add push the dotfiles
gitpush_dotfiles() {
    cd ~/dotfiles
    git add .
    git commit -m "$*"
    git push origin master
    cd -
}
alias gpd=gitpush_dotfiles

seteslint() {
  # sudo npm info "eslint-config-airbnb-base@latest" peerDependencies
  # export PKG=eslint-config-airbnb-base;
  # npm info "$PKG@latest" peerDependencies --json | command sed 's/[\{\},]//g ; s/: /@/g' | xargs npm install --save-dev "$PKG@latest"
  cp ~/.eslintrc .eslintrc
}

# show the file size 
size() {
  file="$1"
  if [ -b "$file" ]; then
    /sbin/blockdev --getsize64 "$file"
  else
    wc -c < "$file"  # Handles pseudo files like /proc/cpuinfo
    # stat --format %s "$file"
    # find "$file" -printf '%s\n'
    # du -b "$file" | cut -f1
  fi
}


# mkdir and cd into it
mkcdir ()
{
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}
alias mkdi=mkcdir



alias babel-node ./node_modules/.bin/babel-node


# for tmux
alias t="tmux a"
alias cdd="cd ~/dotfiles"
alias sozh="so ~/.zshrc"
alias tn="tmux new -s"
alias tnew="tmux new -s"
alias tk="tmux kill-server"
# alias vimr="cd ~/dotfiles && nvim nvim/init.vim"
alias vimr="vim ~/.vimrc"
alias nvimr="nvim ~/.config/nvim/init.vim"
# alias zshr="cd ~/dotfiles && nvim .zshrc"
alias rm="trash"
alias zshr="vim ~/.zshrc"
alias so="source"
alias szh="source ~/.zshrc"
alias cdo="cd ~/dotfiles"
alias cno="cd ~/dev/node"
alias czh="v ~/.zshrc"
alias eslint="./node_modules/.bin/eslint"
alias gs="git status"
alias ga="git add ."
alias gch="git checkout"
alias gcm="git commit -m"
# alias gp="git push origin master"
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
alias read="vim README.md"
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

# for emoj
alias :mm=":memo:"

# for docker info below
# https://docs.docker.com/compose/completion/
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# for node projects
export PATH=$PATH:./node_modules/.bin


function gi() { curl -L -s https://www.gitignore.io/api/$@ ;} >> .gitignore
