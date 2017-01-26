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

# alias vo=nvim $(fzf)

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
# alias v="nvim"
# alias vim="nvim"
alias py="python3"
alias read="nvim README.md"
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
alias cat=hicat
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

export NVIM_TUI_ENABLE_CURSOR_SHAPE=1



# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
#
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}


fo() {
 local out file key
 IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
 key=$(head -1 <<< "$out")
 file=$(head -2 <<< "$out" | tail -1)
 if [ -n "$file" ]; then
   [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
 fi
}


# v - open files in ~/.viminfo
# v() {
#   local files
#   files=$(grep '^>' ~/.viminfo | cut -c3- |
#           while read line; do
#             [ -f "${line/\~/$HOME}" ] && echo "$line"
#           done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
# }
#
#
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}



# alias v=nvim $(fzf)
